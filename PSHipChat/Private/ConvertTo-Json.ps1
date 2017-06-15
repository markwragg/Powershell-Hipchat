#Required only for Powershell 2
if ($PSVersionTable.PSVersion.Major -lt 3 ){
          
    function ConvertTo-Json([object] $item){
        add-type -assembly system.web.extensions
        $ps_js=new-object system.web.script.serialization.javascriptSerializer
        return $ps_js.Serialize($item)
    }

}