!function(o,s,u){function h(e){!0===d&&(d=e||1);for(var t=l.length-1;0<=t;t--){var i=o(l[t]);if(i[0]==s||i.is(":visible")){var n=i.width(),a=i.height(),r=i.data(v);!r||n===r.w&&a===r.h||(i.trigger(f,[r.w=n,r.h=a]),d=e||!0)}else(r=i.data(v)).w=0,r.h=0}null!==m&&(d&&(null==e||e-d<1e3)?m=s.requestAnimationFrame(h):(m=setTimeout(h,c[g]),d=!1))}var m,l=[],c=o.resize=o.extend(o.resize,{}),d=!1,i="setTimeout",f="resize",v=f+"-special-event",g="pendingDelay",t="activeDelay",n="throttleWindow";c[g]=200,c[t]=20,c[n]=!0,o.event.special[f]={setup:function(){if(!c[n]&&this[i])return!1;var e=o(this);l.push(this),e.data(v,{w:e.width(),h:e.height()}),1===l.length&&(m=u,h())},teardown:function(){if(!c[n]&&this[i])return!1;for(var e=o(this),t=l.length-1;0<=t;t--)if(l[t]==this){l.splice(t,1);break}e.removeData(v),l.length||(d?cancelAnimationFrame(m):clearTimeout(m),m=null)},add:function(e){function t(e,t,i){var n=o(this),a=n.data(v)||{};a.w=t!==u?t:n.width(),a.h=i!==u?i:n.height(),r.apply(this,arguments)}return!(!c[n]&&this[i])&&(o.isFunction(e)?(r=e,t):(r=e.handler,void(e.handler=t)));var r}},s.requestAnimationFrame||(s.requestAnimationFrame=s.webkitRequestAnimationFrame||s.mozRequestAnimationFrame||s.oRequestAnimationFrame||s.msRequestAnimationFrame||function(e){return s.setTimeout(function(){e((new Date).getTime())},c[t])}),s.cancelAnimationFrame||(s.cancelAnimationFrame=s.webkitCancelRequestAnimationFrame||s.mozCancelRequestAnimationFrame||s.oCancelRequestAnimationFrame||s.msCancelRequestAnimationFrame||clearTimeout)}(jQuery,this),function(){function e(t){function i(){var e=t.getPlaceholder();0!=e.width()&&0!=e.height()&&(t.resize(),t.setupGrid(),t.draw())}function e(e){e.getPlaceholder().resize(i)}function n(e){e.getPlaceholder().unbind("resize",i)}t.hooks.bindEvents.push(e),t.hooks.shutdown.push(n)}var t={};jQuery.plot.plugins.push({init:e,options:t,name:"resize",version:"1.0"})}();