module ApplicationHelper
  def format_datetime(datetime)
    datetime.try(:strftime, '%Y/%m/%d %H:%M')
  end

  def format_datetime_ymd(datetime)
    datetime.try(:strftime, '%Y/%m/%d')
  end

  def format_boolean(bool)
  	bool ? "◯" : "✕"
  end

  def format_activity(bool)
    bool ? "有効" : "無効"
  end

  def active_namespace(namespace, action = nil)
    if (action)
      path = request.path
      name = request.path.split('/')[1]
      return name == namespace && path.include?(action) ? true : false
    else
      name = request.path.split('/')[1]
      return name == namespace ? true : false
    end
  end

  def active_statistic
    return (current_page?(statistics_products_path) || current_page?(statistics_sessions_path) ||
                    current_page?(partner_sites_path) || current_page?(conversion_tags_path))
  end

  def split_string_to_array(*str)
    arr = str.join(',').split(',')
    arr.delete("")
    arr
  end

  def format_chatbot_script(api_key, aibot_address, server_host)
    %Q(<style>#aicb_iframe{position:fixed;right:0;bottom:0;z-index:10000;width:30%}@media screen and (max-width:1024px){#aicb_iframe{width:50%}}@media screen and (max-width:768px){#aicb_iframe{width:100%}}.disable_scroll{position:fixed;overflow:hidden}</style><script type="text/javascript">function aicb_isMobile(){return navigator.userAgent.match(/Android/i)||navigator.userAgent.match(/webOS/i)||navigator.userAgent.match(/iPhone/i)||navigator.userAgent.match(/iPad/i)||navigator.userAgent.match(/iPod/i)||navigator.userAgent.match(/BlackBerry/i)||navigator.userAgent.match(/Windows Phone/i)?!0:!1}function getMetaKeywords(){for(var e=document.getElementsByTagName("meta"),t=0;t<e.length;t++)if("keywords"==e[t].getAttribute("name")||"Keywords"==e[t].getAttribute("name"))return e[t].getAttribute("content");return""}function receiveMessage(e){void 0!=e.data.isOpened&&("true"===e.data.isOpened?(enable_native_touch(),document.getElementById("aicb_iframe").style.height="100%"):(disable_native_touch(),document.getElementById("aicb_iframe").style.height="90px"),document.getElementById("aicb_iframe").contentWindow.postMessage({iframe_height:window.innerHeight.toString()},aicb_host))}function enable_native_touch(){aicb_isMobile()&&document.body.classList.add("disable_scroll")}function disable_native_touch(){aicb_isMobile()&&document.body.classList.remove("disable_scroll")}function aicb_ajax(e,t,a){return new Promise(function(a,n){var i=new XMLHttpRequest;i.open(e,server_host+t),i.setRequestHeader("Content-Type","application/json"),i.setRequestHeader("Authorization",'Token token="'+api_key+'"'),i.onload=function(){200===i.status?a(i.response):n({status:this.status,statusText:i.statusText})},i.onerror=function(){n({status:this.status,statusText:i.statusText})},i.send()})}var aicb_host="#{aibot_address}",api_key="#{api_key}",server_host="#{server_host}";window.addEventListener("resize",function(){null!==document.getElementById("aicb_iframe")&&document.getElementById("aicb_iframe").contentWindow.postMessage({iframe_height:window.innerHeight.toString()},aicb_host)},!1),document.addEventListener("DOMContentLoaded",function(){var e=getMetaKeywords(),t=!0;aicb_ajax("get","/v1/initial_chatbot.json?meta_keywords="+e,{}).then(function(e){if(e=JSON.parse(e),"false"==e.existed&&(t=!1),t){var a=document.createElement("iframe");a.onload=function(){var t=null;null!==e.chatbot&&void 0!==e.chatbot&&(t={id:e.chatbot.id,name:e.chatbot.name,profile:e.chatbot.profile,image_url:e.chatbot.photos[0].image_url,line:e.chatbot.line,tutorial:e.chatbot.tutorial}),document.getElementById("aicb_iframe").contentWindow.postMessage({api_key:api_key,meta_keywords:getMetaKeywords(),text_message:e.text_message,chatbot:t},aicb_host)},a.setAttribute("src",aicb_host),a.style.height="90px",a.style.border="none",a.id="aicb_iframe",document.body.appendChild(a)}})["catch"](function(e){console.error("Augh, there was an error!",e.statusText)})}),window.addEventListener("message",receiveMessage,!1);</script>)
  end

  def format_cv_tag_script(api_key, server_host)
    %Q(<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fingerprintjs2/1.5.1/fingerprint2.min.js"></script><script>function aicb_ajax(t,e,n){return new Promise(function(s,r){var a=new XMLHttpRequest;a.open(t,server_host+e),a.setRequestHeader("Content-Type","application/json"),a.setRequestHeader("Authorization",'Token token="'+api_key+'"'),a.onload=function(){200===a.status?s(a.response):r({status:this.status,statusText:a.statusText})},a.onerror=function(){r({status:this.status,statusText:a.statusText})},a.send(JSON.stringify(n))})}function getParameter(t){var e=null,n=[];return location.search.substr(1).split("&").forEach(function(s){n=s.split("="),n[0]===t&&(e=decodeURIComponent(n[1]))}),e}var api_key="#{api_key}",server_host="#{server_host}";document.addEventListener("DOMContentLoaded",function(){(new Fingerprint2).get(function(t){aicb_ajax("post","/v1/tracking_cv_tag",{current_url:document.location.href,referrer:document.referrer,fingerprint:t,session_statistic_id:getParameter("aretecoid"),api_key:api_key}).then(function(t){t=JSON.parse(t)})["catch"](function(t){})})});</script>)
  end
end
