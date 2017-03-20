xquery version "1.0-ml";
import module namespace sem = "http://marklogic.com/semantics" 
      at "/MarkLogic/semantics.xqy";
declare namespace cnt = "https://schema.hsbc-demo.com/ns/content/";


declare function local:enrich-dataSet($doc as element(), $uri as xs:string, $root-node as xs:string)
{
 let $uniqueKey as xs:string := $doc/DatasetID
 let $contentType := 'https://schema.hsbc-demo.com/ns/content/DataSet'
 let $subject as xs:string := fn:concat($contentType, "/" , $uniqueKey)

 let $techGroupUniqueKey as xs:string := $doc/TechGroupID
 let $techGroupContentType := 'https://schema.hsbc-demo.com/ns/content/TechGroup'
 let $techGroupSubject as xs:string := fn:concat($techGroupContentType, "/" , $techGroupUniqueKey)

 let $techSysUniqueKey as xs:string := $doc/TechSystemID
 let $techSysContentType := 'https://schema.hsbc-demo.com/ns/content/TechSystem'
 let $techSysSubject as xs:string := fn:concat($techSysContentType, "/" , $techSysUniqueKey)
 
 let $domUniqueKey as xs:string := fn:distinct-values($doc/DomainID)
 let $domContentType := 'https://schema.hsbc-demo.com/ns/content/Domain'
 let $domSubject as xs:string := fn:concat($domContentType, "/" , $domUniqueKey)

 let $appUniqueKey as xs:string := $doc/ApplicationID
 let $appContentType := 'https://schema.hsbc-demo.com/ns/content/Application'
 let $appSubject as xs:string := fn:concat($appContentType, "/" , $appUniqueKey)

 let $sysUniqueKey as xs:string := $doc/SystemID
 let $sysContentType := 'https://schema.hsbc-demo.com/ns/content/System'
 let $sysSubject as xs:string := fn:concat($sysContentType, "/" , $sysUniqueKey) 
  
 return
    <sem:triples> {    
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'), 
        sem:iri($contentType)
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasPrimaryKey' ), 
        xs:string( $uniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasDataSetKey' ), 
        xs:string( $uniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasDataSetKey' ), 
        xs:string( $techGroupUniqueKey )
      ), 
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasDataSetKey' ), 
        xs:string( $techSysUniqueKey )
      ), 
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasDataSetKey' ), 
        xs:string( $sysUniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasDataSetKey' ), 
        xs:string( $appUniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasUri' ), 
        $uri
        ),   
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/belongsTo' ), 
        sem:iri($techGroupSubject)
        ),
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'http://purl.org/dc/terms/isPartOf' ), 
        sem:iri( $techGroupUniqueKey )
        ),
        sem:triple(
        sem:iri( $techGroupUniqueKey ), 
        sem:iri( 'http://purl.org/dc/terms/hasPart' ), 
        sem:iri( $subject )
        ),
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'http://purl.org/dc/terms/isPartOf' ), 
        sem:iri( $appUniqueKey )
        ),
        sem:triple(
        sem:iri( $appUniqueKey ), 
        sem:iri( 'http://purl.org/dc/terms/hasPart' ), 
        sem:iri( $subject )
        )                     
    }
    </sem:triples>
};

declare function local:enrich-techGroup($doc as element(), $uri as xs:string, $root-node as xs:string)
{
 let $uniqueKey as xs:string := $doc/TechGroupID
 let $contentType := 'https://schema.hsbc-demo.com/ns/content/TechGroup'
 let $subject as xs:string := fn:concat($contentType, "/" , $uniqueKey)

 let $techSysUniqueKey as xs:string := $doc/TechSystemID
 let $techSysContentType := 'https://schema.hsbc-demo.com/ns/content/TechSystem'
 let $techSysSubject as xs:string := fn:concat($techSysContentType, "/" , $techSysUniqueKey)
 
 let $domUniqueKey as xs:string := $doc/DomainID
 let $domContentType := 'https://schema.hsbc-demo.com/ns/content/Domain'
 let $domSubject as xs:string := fn:concat($domContentType, "/" , $domUniqueKey)

 return
    <sem:triples> {    
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'), 
        sem:iri( $contentType )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasPrimaryKey' ), 
        xs:string( $uniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasTechGroupKey' ), 
        xs:string( $uniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasTechGroupKey' ), 
        xs:string( $techSysUniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasTechGroupKey' ), 
        xs:string( $domUniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasUri' ), 
        $uri
        ),   
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/belongsTo' ), 
        sem:iri($techSysSubject)
        ),
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'http://purl.org/dc/terms/isPartOf' ), 
        sem:iri( $techSysSubject )
        ),
        sem:triple(
        sem:iri( $techSysSubject ), 
        sem:iri( 'http://purl.org/dc/terms/hasPart' ), 
        sem:iri( $subject )
        )                      
    }
    </sem:triples>
};

declare function local:enrich-techSystem($doc as element(), $uri as xs:string, $root-node as xs:string)
{
 let $uniqueKey as xs:string := $doc/TechSystemID
 let $contentType := 'https://schema.hsbc-demo.com/ns/content/TechSystem'
 let $subject as xs:string := fn:concat($contentType, "/" , $uniqueKey)
 
 let $domUniqueKey as xs:string := $doc/DomainID
 let $domContentType := 'https://schema.hsbc-demo.com/ns/content/Domain'
 let $domSubject as xs:string := fn:concat($domContentType, "/" , $domUniqueKey)
 return
    <sem:triples> {    
      sem:triple( 
        sem:iri($subject), 
        sem:iri('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'), 
        sem:iri($contentType)
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasPrimaryKey' ), 
        xs:string( $uniqueKey )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasTechSystemKey' ), 
        xs:string( $uniqueKey )
      ),  
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasTechSystemKey' ), 
        xs:string( $domUniqueKey )
      ),     
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasUri' ), 
        $uri
        ),
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/belongsTo' ), 
        sem:iri( $domSubject )
        ),
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'http://purl.org/dc/terms/isPartOf' ), 
        sem:iri( $domSubject )
        ),
        sem:triple(
        sem:iri( $domSubject ), 
        sem:iri( 'http://purl.org/dc/terms/hasPart' ), 
        sem:iri( $subject )
        )                   
    }
    </sem:triples>
};

declare function local:enrich-executable($doc as element(), $uri as xs:string, $root-node as xs:string)
{
 let $uniqueKey as xs:string := $doc/ExecutableID
 let $contentType := 'https://schema.hsbc-demo.com/ns/content/Executable'
 let $subject as xs:string := fn:concat($contentType, "/" , $uniqueKey)

 let $appUniqueKey as xs:string := $doc/ApplicationID
 let $appContentType := 'https://schema.hsbc-demo.com/ns/content/Application'
 let $appSubject as xs:string := fn:concat($appContentType, "/" , $appUniqueKey)

 let $sysUniqueKey as xs:string := $doc/SystemID
 let $sysContentType := 'https://schema.hsbc-demo.com/ns/content/System'
 let $sysSubject as xs:string := fn:concat($sysContentType, "/" , $sysUniqueKey)

 let $domUniqueKey as xs:string := $doc/DomainID
 let $domContentType := 'https://schema.hsbc-demo.com/ns/content/Domain'
 let $domSubject as xs:string := fn:concat($domContentType, "/" , $domUniqueKey)

 let $techGroupUniqueKey as xs:string := $doc/TechGroupID
 let $techGroupContentType := 'https://schema.hsbc-demo.com/ns/content/TechGroup'
 let $techGroupSubject as xs:string := fn:concat($techGroupContentType, "/" , $techGroupUniqueKey)

 let $techSysUniqueKey as xs:string := $doc/TechSystemID
 let $techSysContentType := 'https://schema.hsbc-demo.com/ns/content/TechSystem'
 let $techSysSubject as xs:string := fn:concat($techSysContentType, "/" , $techSysUniqueKey)

 return
    <sem:triples> {    
      sem:triple( 
        sem:iri($subject), 
        sem:iri('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'), 
        sem:iri($contentType)
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasPrimaryKey' ), 
        xs:string( $uniqueKey )
      ),      
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasExecutableKey' ), 
        xs:string($uniqueKey)
      ),    
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasExecutableKey' ), 
        xs:string($appUniqueKey)
      ),    
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasExecutableKey' ), 
        xs:string($sysUniqueKey)
      ), 
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasExecutableKey' ), 
        xs:string($domUniqueKey)
      ), 
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasExecutableKey' ), 
        xs:string( $techSysUniqueKey )
      ), 
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasExecutableKey' ), 
        xs:string( $techGroupUniqueKey )
      ),   
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasUri' ), 
        $uri
        ),   
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/belongsTo' ), 
        sem:iri($appSubject)
        ),
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'http://purl.org/dc/terms/isPartOf' ), 
        sem:iri( $appSubject )
        ),
        sem:triple(
        sem:iri( $appSubject ), 
        sem:iri( 'http://purl.org/dc/terms/hasPart' ), 
        sem:iri( $subject )
        ),
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'http://purl.org/dc/terms/isPartOf' ), 
        sem:iri( $techGroupSubject )
        ),
        sem:triple(
        sem:iri( $techGroupSubject ), 
        sem:iri( 'http://purl.org/dc/terms/hasPart' ), 
        sem:iri( $subject )
        )                     
    }
    </sem:triples>
};

declare function local:enrich-application($doc as element(), $uri as xs:string, $root-node as xs:string)
{
 let $uniqueKey as xs:string := $doc/ApplicationID
 let $contentType := 'https://schema.hsbc-demo.com/ns/content/Application'
 let $subject as xs:string := fn:concat($contentType, "/" , $uniqueKey)

 let $sysUniqueKey as xs:string := $doc/SystemID
 let $sysContentType := 'https://schema.hsbc-demo.com/ns/content/System'
 let $sysSubject as xs:string := fn:concat($sysContentType, "/" , $sysUniqueKey)

 let $domUniqueKey as xs:string := $doc/DomainID
 let $domContentType := 'https://schema.hsbc-demo.com/ns/content/Domain'
 let $domSubject as xs:string := fn:concat($domContentType, "/" , $domUniqueKey)
  
 return
    <sem:triples> {    
      sem:triple( 
        sem:iri($subject), 
        sem:iri('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'), 
        sem:iri($contentType)
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasPrimaryKey' ), 
        xs:string( $uniqueKey )
      ), 
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasApplicationKey' ), 
        xs:string($uniqueKey)
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasApplicationKey' ), 
        xs:string($sysUniqueKey)
      ), 
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasApplicationKey' ), 
        xs:string($domUniqueKey)
      ),     
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasUri' ), 
        $uri
        ),   
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/belongsTo' ), 
        sem:iri($sysSubject)
        ),
              sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'http://purl.org/dc/terms/isPartOf' ), 
        sem:iri( $sysSubject )
        ),
        sem:triple(
        sem:iri( $sysSubject ), 
        sem:iri( 'http://purl.org/dc/terms/hasPart' ), 
        sem:iri( $subject )
        )
    }
    </sem:triples>
};

declare function local:enrich-system($doc as element(), $uri as xs:string, $root-node as xs:string)
{
 let $uniqueKey as xs:string := $doc/SystemID
 let $contentType := 'https://schema.hsbc-demo.com/ns/content/System'
 let $subject as xs:string := fn:concat($contentType, "/" , $uniqueKey)
 
 let $domUniqueKey as xs:string := $doc/DomainID
 let $domContentType := 'https://schema.hsbc-demo.com/ns/content/Domain'
 let $domSubject as xs:string := fn:concat($domContentType, "/" , $domUniqueKey)
 return
    <sem:triples> {    
      sem:triple( 
        sem:iri($subject), 
        sem:iri('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'), 
        sem:iri( $contentType )
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasPrimaryKey' ), 
        xs:string( $uniqueKey )
      ),    
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasSystemKey' ), 
        xs:string( $domUniqueKey )
      ), 
       sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasSystemKey' ), 
        xs:string( $uniqueKey )
      ), 
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasUri' ), 
        $uri
        ),
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/belongsTo' ), 
        sem:iri( $domSubject )
        ),   
      sem:triple(
        sem:iri( $subject ), 
        sem:iri( 'http://purl.org/dc/terms/isPartOf' ), 
        sem:iri( $domSubject )
        ),
        sem:triple(
        sem:iri( $domSubject ), 
        sem:iri( 'http://purl.org/dc/terms/hasPart' ), 
        sem:iri( $subject )
        ) 
    }
    </sem:triples>
};

declare function local:enrich-domain($doc as element(), $uri as xs:string, $root-node as xs:string)
{
 let $uniqueKey as xs:string := $doc/DomainID
 let $contentType := 'https://schema.hsbc-demo.com/ns/content/Domain'
 let $subject as xs:string := fn:concat($contentType, "/" , $uniqueKey)
 return
    <sem:triples> {    
      sem:triple( 
        sem:iri($subject), 
        sem:iri('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'), 
        sem:iri($contentType)
      ),
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasPrimaryKey' ), 
        xs:string($uniqueKey)
      ),    
      sem:triple( 
        sem:iri( $subject ), 
        sem:iri( 'https://schema.hsbc-demo.com/ns/content/hasUri' ), 
        $uri
        )
    }
    </sem:triples>
};

declare function local:enrich($doc as element(), $uri as xs:string, $root-node as xs:string)
{
    typeswitch($doc)
      case (element(Domain))
      return 
       <cnt:envelope>{
          local:enrich-domain($doc, $uri, $root-node),
          <cnt:source>{$doc}</cnt:source>
        }</cnt:envelope>
      case (element(System))
      return
       <cnt:envelope>{
          local:enrich-system($doc, $uri, $root-node),
          <cnt:source>{$doc}</cnt:source>
        }</cnt:envelope>      
      case (element(Application))
      return
       <cnt:envelope>{
          local:enrich-application($doc, $uri, $root-node),
          <cnt:source>{$doc}</cnt:source>
        }</cnt:envelope>      
      case (element(Executable))
      return
       <cnt:envelope>{
          local:enrich-executable($doc, $uri, $root-node),
          <cnt:source>{$doc}</cnt:source>
        }</cnt:envelope>   
      case (element(TechSystem))
      return
       <cnt:envelope>{
          local:enrich-techSystem($doc, $uri, $root-node),
          <cnt:source>{$doc}</cnt:source>
        }</cnt:envelope>  

      case (element(TechGroup))
      return
       <cnt:envelope>{
          local:enrich-techGroup($doc, $uri, $root-node),
          <cnt:source>{$doc}</cnt:source>
        }</cnt:envelope>  

      case (element(DataSet))
      return
       <cnt:envelope>{
          local:enrich-dataSet($doc, $uri, $root-node),
          <cnt:source>{$doc}</cnt:source>
        }</cnt:envelope>   

      case (element(cnt:envelope))
      return
          local:enrich($doc/cnt:source/element(), $uri, $root-node)
      default
      return "Type not identified"
 
};

for $doc in fn:collection("sourceData")/node()
let $root-node := (fn:local-name($doc))
let $enriched-node := local:enrich($doc, fn:string(fn:base-uri($doc)), $root-node)
return 
  if($enriched-node = "Type not identified")
  then ()
  else  
    xdmp:node-replace($doc, $enriched-node)