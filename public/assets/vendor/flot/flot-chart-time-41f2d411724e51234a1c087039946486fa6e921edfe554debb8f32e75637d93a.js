!function(e){function t(e,t){return t*Math.floor(e/t)}function n(e,t,n,r){if("function"==typeof e.strftime)return e.strftime(t);var a,i=function(e,t){return t=""+(null==t?"0":t),1==(e=""+e).length?t+e:e},o=[],s=!1,u=e.getHours(),c=u<12;null==n&&(n=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]),null==r&&(r=["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]),a=u>12?u-12:0==u?12:u;for(var m=0;m<t.length;++m){var l=t.charAt(m);if(s){switch(l){case"a":l=""+r[e.getDay()];break;case"b":l=""+n[e.getMonth()];break;case"d":l=i(e.getDate());break;case"e":l=i(e.getDate()," ");break;case"h":case"H":l=i(u);break;case"I":l=i(a);break;case"l":l=i(a," ");break;case"m":l=i(e.getMonth()+1);break;case"M":l=i(e.getMinutes());break;case"q":l=""+(Math.floor(e.getMonth()/3)+1);break;case"S":l=i(e.getSeconds());break;case"y":l=i(e.getFullYear()%100);break;case"Y":l=""+e.getFullYear();break;case"p":l=c?"am":"pm";break;case"P":l=c?"AM":"PM";break;case"w":l=""+e.getDay()}o.push(l),s=!1}else"%"==l?s=!0:o.push(l)}return o.join("")}function r(e){function t(e,t,n,r){e[t]=function(){return n[r].apply(n,arguments)}}var n={date:e};e.strftime!=undefined&&t(n,"strftime",e,"strftime"),t(n,"getTime",e,"getTime"),t(n,"setTime",e,"setTime");for(var r=["Date","Day","FullYear","Hours","Milliseconds","Minutes","Month","Seconds"],a=0;a<r.length;a++)t(n,"get"+r[a],e,"getUTC"+r[a]),t(n,"set"+r[a],e,"setUTC"+r[a]);return n}function a(e,t){if("browser"==t.timezone)return new Date(e);if(t.timezone&&"utc"!=t.timezone){if("undefined"!=typeof timezoneJS&&"undefined"!=typeof timezoneJS.Date){var n=new timezoneJS.Date;return n.setTimezone(t.timezone),n.setTime(e),n}return r(new Date(e))}return r(new Date(e))}function i(r){r.hooks.processOptions.push(function(r){e.each(r.getAxes(),function(e,r){var i=r.options;"time"==i.mode&&(r.tickGenerator=function(e){var n=[],r=a(e.min,i),o=0,u=i.tickSize&&"quarter"===i.tickSize[1]||i.minTickSize&&"quarter"===i.minTickSize[1]?m:c;null!=i.minTickSize&&(o="number"==typeof i.tickSize?i.tickSize:i.minTickSize[0]*s[i.minTickSize[1]]);for(var l=0;l<u.length-1&&!(e.delta<(u[l][0]*s[u[l][1]]+u[l+1][0]*s[u[l+1][1]])/2&&u[l][0]*s[u[l][1]]>=o);++l);var h=u[l][0],f=u[l][1];if("year"==f){if(null!=i.minTickSize&&"year"==i.minTickSize[1])h=Math.floor(i.minTickSize[0]);else{var k=Math.pow(10,Math.floor(Math.log(e.delta/s.year)/Math.LN10)),d=e.delta/s.year/k;h=d<1.5?1:d<3?2:d<7.5?5:10,h*=k}h<1&&(h=1)}e.tickSize=i.tickSize||[h,f];var M=e.tickSize[0];f=e.tickSize[1];var g=M*s[f];"second"==f?r.setSeconds(t(r.getSeconds(),M)):"minute"==f?r.setMinutes(t(r.getMinutes(),M)):"hour"==f?r.setHours(t(r.getHours(),M)):"month"==f?r.setMonth(t(r.getMonth(),M)):"quarter"==f?r.setMonth(3*t(r.getMonth()/3,M)):"year"==f&&r.setFullYear(t(r.getFullYear(),M)),r.setMilliseconds(0),g>=s.minute&&r.setSeconds(0),g>=s.hour&&r.setMinutes(0),g>=s.day&&r.setHours(0),g>=4*s.day&&r.setDate(1),g>=2*s.month&&r.setMonth(t(r.getMonth(),3)),g>=2*s.quarter&&r.setMonth(t(r.getMonth(),6)),g>=s.year&&r.setMonth(0);var y,S=0,z=Number.NaN;do{if(y=z,z=r.getTime(),n.push(z),"month"==f||"quarter"==f)if(M<1){r.setDate(1);var p=r.getTime();r.setMonth(r.getMonth()+("quarter"==f?3:1));var T=r.getTime();r.setTime(z+S*s.hour+(T-p)*M),S=r.getHours(),r.setHours(0)}else r.setMonth(r.getMonth()+M*("quarter"==f?3:1));else"year"==f?r.setFullYear(r.getFullYear()+M):r.setTime(z+g)}while(z<e.max&&z!=y);return n},r.tickFormatter=function(e,t){var r=a(e,t.options);if(null!=i.timeformat)return n(r,i.timeformat,i.monthNames,i.dayNames);var o=t.options.tickSize&&"quarter"==t.options.tickSize[1]||t.options.minTickSize&&"quarter"==t.options.minTickSize[1],u=t.tickSize[0]*s[t.tickSize[1]],c=t.max-t.min,m=i.twelveHourClock?" %p":"",l=i.twelveHourClock?"%I":"%H";return n(r,u<s.minute?l+":%M:%S"+m:u<s.day?c<2*s.day?l+":%M"+m:"%b %d "+l+":%M"+m:u<s.month?"%b %d":o&&u<s.quarter||!o&&u<s.year?c<s.year?"%b":"%b %Y":o&&u<s.year?c<s.year?"Q%q":"Q%q %Y":"%Y",i.monthNames,i.dayNames)})})})}var o={xaxis:{timezone:null,timeformat:null,twelveHourClock:!1,monthNames:null}},s={second:1e3,minute:6e4,hour:36e5,day:864e5,month:2592e6,quarter:7776e6,year:525949.2*60*1e3},u=[[1,"second"],[2,"second"],[5,"second"],[10,"second"],[30,"second"],[1,"minute"],[2,"minute"],[5,"minute"],[10,"minute"],[30,"minute"],[1,"hour"],[2,"hour"],[4,"hour"],[8,"hour"],[12,"hour"],[1,"day"],[2,"day"],[3,"day"],[.25,"month"],[.5,"month"],[1,"month"],[2,"month"]],c=u.concat([[3,"month"],[6,"month"],[1,"year"]]),m=u.concat([[1,"quarter"],[2,"quarter"],[1,"year"]]);e.plot.plugins.push({init:i,options:o,name:"time",version:"1.0"}),e.plot.formatDate=n,e.plot.dateGenerator=a}(jQuery);