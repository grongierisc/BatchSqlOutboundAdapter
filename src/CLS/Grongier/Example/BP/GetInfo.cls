/// 
Class Grongier.Example.BP.GetInfo Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='tInfos' type='Example.Msg.Info' collection='list' instantiate='0' />
<property name='key' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='450' >
<call name='GetInfo' target='Batch_Select' async='0' xpos='200' ypos='250' >
<request type='Example.Msg.GetInfoRequest' />
<response type='Example.Msg.GetInfoResponse' >
<assign property="context.tInfos" value="callresponse.Infos" action="set" />
</response>
</call>
<foreach name='ForEach Infos' property='context.tInfos' key='context.key' xpos='200' ypos='350' xend='200' yend='350' >
<trace name='Trace' value='context.tInfos.GetAt(context.key).ProductName' xpos='200' ypos='250' />
</foreach>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
