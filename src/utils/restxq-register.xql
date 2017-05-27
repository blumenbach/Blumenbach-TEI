xquery version "3.0";

import module namespace xrest="http://exquery.org/ns/restxq/exist" at "java:org.exist.extensions.exquery.restxq.impl.xquery.exist.ExistRestXqModule";

xrest:register-module(xs:anyURI($target || "/pages/forms/restxq.xql"))