/* global $ */
require('jquery');

// 関数定義

// 種目・重量・回数・秒数・セット数が空欄であればボタンを隠す
// それ以外は表示する。
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

// turbolinksとjqueryの共存
$(document).on('turbolinks:load', function(){
  
  // メニュー種目10件分の表示・非表示をボタンで切り替える
  $(function(){
    $('.toggle-button').click(function(){
      $('.toggle-show, .toggle-hide').toggle();
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

  // フォームの入力状態に応じてリセットボタンを表示させる（ページ読み込み時）
  $(function(){
    $('.select-children').each(function(){
      if($(this).val().length){
        $(this).closest('tr').find('.btn-reset').show();
      }
    });
  });

  // フォームの入力・消去に応じてリセットボタンを表示・非表示にする
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

});