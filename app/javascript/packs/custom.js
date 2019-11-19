/* global $ */
require('jquery')

// メニュー種目10件分の表示・非表示をボタンで切り替える
$(document).on('turbolinks:load', function(){
  $(function(){
    $('.toggle-button').click(function(){
      $('.toggle-show, .toggle-hide').toggle();
    })
  })
});

// 部位・タイプの選択に応じて種目の選択肢を切り替える
$(document).on('turbolinks:load', function(){
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