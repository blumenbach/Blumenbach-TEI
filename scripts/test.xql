
declare
%templates:wrap
%templates:default("mode", "any")
function list:briefs-all($node as node(), $model as map(*)) {
    let $collection := collection($config:brief-collection)/tei:TEI
    let $queryExpr := query:create-query('.', 'regex')
    for $brief in ($collection//tei:teiHeader[ft:query(., $queryExpr)])
    let $asort := if ($brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname) then
        $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname
    else
        $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/text()
    let $author := if ($brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname) then
        $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/*
    else
        $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/text()
    let $esort :=
        if ($brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname) then
            $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname
        else
            $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/text()
    let $empfanger :=
        if ($brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname) then
            $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/*
        else
            $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/text()
    let $titel :=
        let $title := $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="main"]/text()
        let $id := $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno/tei:idno[@type="RegNr"]
        let $link := './view-brief.html'
        let $href := $link || "?id=" || $id
        return
            <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
    let $dsort := for $date in $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event
    return data($date/@sortKey)
    let $date := $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="iso-origin"]/tei:note/tei:date
    let $id := $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno/tei:idno[@type="RegNr"]
    order by $dsort ascending
    return
        <tr>
            <td>
                <span>{$id}</span>
            </td>
            <td>
                <span>{$dsort}</span>
            </td>
            <td>
                <span>{$date}</span>
            </td>
            <td>
                <span>{$asort}</span>
            </td>
            <td>
                <span>{$author}</span>
            </td>
            <td>
                <span>{$esort}</span>
            </td>
            <td>
                <span>{$empfanger}</span>
            </td>
            <td>
                <span>{$titel}</span>
            </td>
        </tr>
};
