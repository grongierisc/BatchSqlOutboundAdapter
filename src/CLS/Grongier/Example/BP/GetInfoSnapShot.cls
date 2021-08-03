/// 
Class Grongier.Example.BP.GetInfoSnapShot Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='tSnapShot' type='EnsLib.SQL.Snapshot' instantiate='0' />
</context>
<sequence xend='200' yend='450' >
<call name='GetInfo' target='Batch_Select' async='0' xpos='200' ypos='250' >
<request type='Example.Msg.GetInfoSnapShotRequest' />
<response type='Example.Msg.GetInfoSnapShotResponse' >
<assign property="context.tInfos" value="callresponse.Infos" action="set" />
</response>
</call>
<while name='SnapShot' condition='context.tSnapShot.%Next()' xpos='366' ypos='314' xend='200' yend='550' >
<trace name='Info' value='context.tSnapShot.Get("ProductName")' xpos='369' ypos='329' />
</while>
</sequence>
</process>
}


}
