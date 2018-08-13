// yli@kx.com
/- 2017.11.10 in Dublin
/- 2017.12.14 added function superSearch
/- 2017.12.19 added default namespace functions  
/- 2018.03.05 handle the exception of .alf..surv.profile.init

system"c 50 100"
\d .ns

// - check all space's size in Bytes
checkNamespaces:{
	`sumSizes xdesc {kx:key x;sizes:{@[{-22!x};x;0]} each x each kx;sumSizes:sum sizes;`nameSpace`sumSizes`Vars!(x;sumSizes;kx!sizes)}each  `$".",/: string each `,key `}

// - check the certain namespace size 
drilldownNamespace:{[namespace] 
	desc flip exec Vars from checkNamespaces[] where nameSpace=namespace}

// - get all functions
`af set raze {`ns xcols update ns:x from([]funcs:f;search:lower f:system"f ",string` sv `,x)}each `,4_key`;
`search set {s:$["*"in s:$[10=abs type x;x;string x];s;"*",s,"*"];r:select (` sv'`,'ns,'funcs)from af where search like s;update args:{(get get x)1}each funcs from r};

// - expand to have functions args and its invoked functions 
`ns_af set afn,'exec args_calls from  update args_calls:{`args`calls!$[100=type f:@[get;x;3#`invalid];(get f) 1 3;``]}each name from afn:update name:(` sv'`,'ns,'funcs) from af;
`searchNs set {select name,args,calls from ns_af where ns = x};
/***/ usage -- searchNs `dl  // `dl is a namespace name

`superSearch set {s:$["*"in s:$[10=abs type x;x;string x];s;"*",s,"*"];`name`args`calls#select from ns_af where search like s};
/***/ usage -- superSearch `email // `email is keyword to search 

\d .   
