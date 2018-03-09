(function() {
  $(function() {
    $('#m_textarea').richText({
      bold: true,
      italic: true,
      underline: true,
      leftAlign: true,
      centerAlign: true,
      rightAlign: true,
      ol: false,
      ul: false,
      heading: true,
      fontColor: true,
      imageUpload: false,
      fileUpload: false,
      videoEmbed: false,
      urls: false,
      table: false,
      removeStyles: false,
      code: true,
      colors: [],
      fileHTML: '',
      imageHTML: '',
      useSingleQuotes: false
    });
    window.emojiPicker = new EmojiPicker({
      emojiable_selector: '[data-emojiable=true]',
      assetsPath: './../assets/img',
      popupButtonClasses: 'fa fa-smile-o'
    });
    return window.emojiPicker.discover();
  });

}).call(this);
