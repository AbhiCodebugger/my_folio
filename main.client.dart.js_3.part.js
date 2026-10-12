((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,B={
kd(){return new B.aB(null)},
aB:function aB(d){this.a=d}}
A=c[0]
C=c[5]
B=a.updateHolder(c[4],B)
B.aB.prototype={
co(){var x,w,v,u=b.G,t=A.A(A.k(u.document).documentElement)
if(t==null)return
w=A.b4(t.getAttribute("data-theme"))
if(w==null)w=A.b3(A.k(A.k(u.window).matchMedia("(prefers-color-scheme: dark)")).matches)?"dark":"light"
x=w==="dark"?"light":"dark"
t.setAttribute("data-theme",x)
try{A.k(A.k(u.window).localStorage).setItem("theme",x)}catch(v){}},
O(d){var x="Toggle dark mode",w=y.g
w=A.bT(["type","button","aria-label",x,"title",x],w,w)
return C.iY(A.f([new C.bh('<svg class="icon-moon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/></svg>',null),new C.bh('<svg class="icon-sun" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41"/></svg>',null)],y.h),w,"icon-btn theme-toggle",this.gcn())}}
var z=a.updateTypes(["~()"]);(function installTearOffs(){var x=a._instance_0u
x(B.aB.prototype,"gcn","co",0)})();(function inheritance(){var x=a.inherit
x(B.aB,C.O)})()
A.fq(b.typeUniverse,JSON.parse('{"aB":{"O":[],"m":[]}}'))
var y={h:A.K("q<m>"),g:A.K("b")}};
(a=>{a["HY7JRAB+7O5YXJaDqGZnC2Oi9rE="]=a.current})($__dart_deferred_initializers__);
//# sourceMappingURL=main.client.dart.js_3.part.js.map
