import $ from 'jquery';
import Rails from '@rails/ujs';
import smoothscroll from 'smoothscroll-polyfill';

// kick off the polyfill!
smoothscroll.polyfill();


// 関数定義

// 種目・重量・回数・秒数・セット数が空欄であればボタンを隠す
// それ以外は表示する
function toggle() {
  var $button = $(this).closest('tr').find('.btn-reset');
  var $selectChildren = $(this).closest('tr').find('.select-children');
  var $input = $(this).closest('tr').find('input');
  // 部位・タイプを変更してもボタンは表示しないようにする
  if($(this).attr('id') != 'parts_types' && $(this).val().length){
    if($button.css('display') == 'none'){
      $button.show();
    }
  } else{
      var data = [];
      $input.each(function(index, dom){
        if($(dom).val() !== ''){
      	  data.push($(dom).val());
        }
      });
      // 部位・タイプの場合、種目は自動的に空欄になるため、inputのみ検証する
      if($(this).attr('id') == 'parts_types' && !data.length){
        $button.hide();
      } else if(!$selectChildren.val().length && !data.length){
        $button.hide();
      }
  }
}

// 達成率を計算する
function calculateRate() {
  var checkCount = $('input[type="checkbox"]:checked').length;
  var formCount = $('form').length;
  var rate = Math.round(checkCount / formCount * 100);
  $('#rate').html(rate);
}


// 即時関数
  
// フラッシュメッセージをフェードアウトさせる
$(function(){
  setTimeout("$('.alert-success').fadeOut('slow')", 3000);
});

// メニュー種目10件分の表示・非表示をボタンで切り替える
$(function(){
  $('.toggle-button').click(function(){
    $('.toggle-show, .toggle-hide').toggle();
    // メニュー種目10件目の角の丸みをボタンで切り替える
    $('tbody tr:nth-child(11)').toggleClass('toggle-radius');
  });
});

// リセットボタンが押されるとフォームをリセットする
$(function(){
  $('.btn-reset').click(function(){
    $(this).hide().closest('tr').find('.select-parent')
                                .val('部位・タイプで選ぶ').end()
                                .find('.select-children, input')
                                .val('');
  });
});

// フォームの入力状態に応じてリセットボタンの表示・非表示を切り替える
// （ページ読み込み時）
$(function(){
  $('.select-children').each(function(){
    var $button = $(this).closest('tr').find('.btn-reset');
    if($(this).val().length){
      $button.show();
    } else{
        var $input = $(this).closest('tr').find('input');
        var data = [];
        $input.each(function(index, dom){
          if($(dom).val() !== ''){
        	  data.push($(dom).val());
          }
        });
        if(!data.length){
          $button.hide();
        }
    }
  });
});

// フォームの入力・消去に応じてリセットボタンを表示・非表示にする（随時）
$(function(){
  $('.select-parent').change(toggle);
  $('.select-children').change(toggle);
  $('input').change(toggle);
});

// 部位・タイプの選択に応じて種目の選択肢を切り替える
$(function() {
  return (function() {
    var replaceChildrenOptions, replaceSelectOptions;
    replaceSelectOptions = function($select, results) {
      $select.html($('<option>'));
      return $.each(results, function() {
        var option;
        option = $('<option>').val(this.id).text(this.name);
        return $select.append(option);
      });
    };
    // 選択された部位・タイプのオプションから、data-children-pathの値を読み取る
    replaceChildrenOptions = function() {
      var $selectChildren, childrenPath;
      childrenPath = $(this).find('option:selected').data().childrenPath;
      $selectChildren = $(this).closest('td').find('.select-children');
      // childrenPathが存在する = 部位・タイプが選択されている場合、
      // ajaxでサーバーに種目の一覧を問い合わせる
      if (childrenPath != null) {
        return $.ajax({
          url: childrenPath,
          dataType: "json",
          // サーバーから受け取った種目の一覧でセレクトボックスを置き換える
          success: function(results) {
            return replaceSelectOptions($selectChildren, results);
          },
          // 何らかのエラーが発生した場合
          error: function(XMLHttpRequest, textStatus, errorThrown) {
            console.error("Error occurred in replaceChildrenOptions");
            console.log("XMLHttpRequest: " + XMLHttpRequest.status);
            console.log("textStatus: " + textStatus);
            return console.log("errorThrown: " + errorThrown);
          }
        });
        // 部位・タイプが未選択になった場合、種目の選択肢をクリアする
      } else {
        return replaceSelectOptions($selectChildren, []);
      }
    };
    return $('.select-parent').on({
      'change': replaceChildrenOptions
    });
  })();
});

// 種目一覧のプルダウンを選択時にフォーム情報を送信
$(function(){
  $('.select-parts-types').change(function(){
    var form = $(this).closest('.search-form');
    Rails.fire(form[0], "submit");
  });
});

// TOPページ

// チェック状況に応じてボタンを非表示にする（TOP・ページ読み込み時）
$(function(){
  calculateRate();
  $('.top-menu').each(function(){
    var checkCount = $(this).find('form :checked').length;
    var formCount = $(this).find('form').length;
    var $allCheck = $(this).find('.all-check');
    var $allUncheck = $(this).find('.all-uncheck');
    if(checkCount == formCount){
      $allCheck.hide();
    }
    else if(checkCount == 0){
      $allUncheck.hide();
    }
    else{
      $allCheck.show();
      $allUncheck.show();
    }
  });
});

// チェックの操作時にフォーム情報を送信し、ボタンの表示・非表示を切り替える
$(function(){
  $('input[name="item_record[checked]"]').click(function(){
    $(this).closest('form').submit();
    calculateRate();
    var checkCount = $(this).closest('.top-menu').find('form :checked').length;
    var formCount = $(this).closest('.top-menu').find('form').length;
    var $allCheck = $(this).closest('.top-menu').find('.all-check');
    var $allUncheck = $(this).closest('.top-menu').find('.all-uncheck');
    if(checkCount == formCount){
      $allCheck.hide();
    }
    else if(checkCount == 0){
      $allUncheck.hide();
    }
    else{
      $allCheck.show();
      $allUncheck.show();
    }
  });
});

// メニュー名のチェック時にフォーム情報を送信
$(function(){
  $('input[name="menu_record[checked]"]').click(function(){
    $(this).closest('form').submit();
    calculateRate();
  });
});

// 全てのチェックを入れるボタン・外すボタン
$(function(){
  $('.all-check').click(function(){
    var $checkBoxes = $(this).closest('.top-menu')
                      .find('input[type="checkbox"]:not(:checked)');
    $checkBoxes.prop('checked', true);
    $(this).hide();
    $(this).closest('.check-uncheck').find('.all-uncheck').show();
    calculateRate();
  });
  $('.all-uncheck').click(function(){
    var $checkBoxes = $(this).closest('.top-menu')
                      .find('input[type="checkbox"]:checked');
    $checkBoxes.prop('checked', false);
    $(this).hide();
    $(this).closest('.check-uncheck').find('.all-check').show();
    calculateRate();
  });
});

// スムーススクロール
document.addEventListener("click", e => {
  const target = e.target;
  // clickした要素がclass属性、js-smooth-scrollを含まない場合は処理を中断
  if (!target.classList.contains("js-smooth-scroll")) return;
  e.preventDefault();
  if (target.tagName == 'SPAN'){
    const targetId = target.closest('a').hash;
    document.querySelector(targetId).scrollIntoView({
      behavior: "smooth",
      block: "start"
    });
  } else if (target.tagName == 'A'){
    const targetId = target.hash;
    document.querySelector(targetId).scrollIntoView({
      behavior: "smooth",
      block: "start"
    });
  }
});


// サンプル用の一時的なスクリプト

// チェックの操作時にボタンの表示・非表示を切り替え、達成率を計算する
$(function(){
  $('form[action="#"]').find('input[type="checkbox"]').click(function(){
    calculateRate();
    var checkCount = $(this).closest('.top-menu').find('form :checked').length;
    var formCount = $(this).closest('.top-menu').find('form').length;
    var $allCheck = $(this).closest('.top-menu').find('.all-check');
    var $allUncheck = $(this).closest('.top-menu').find('.all-uncheck');
    if(checkCount == formCount){
      $allCheck.hide();
    }
    else if(checkCount == 0){
      $allUncheck.hide();
    }
    else{
      $allCheck.show();
      $allUncheck.show();
    }
  });
});