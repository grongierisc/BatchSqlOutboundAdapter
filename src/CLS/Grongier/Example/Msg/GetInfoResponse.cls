Class Example.Msg.GetInfoResponse Extends Ens.StringResponse
{

Property Infos As list Of Info;

Storage Default
{
<Data name="GetInfoResponseDefaultData">
<Subscript>"GetInfoResponse"</Subscript>
<Value name="1">
<Value>Infos</Value>
</Value>
</Data>
<DefaultData>GetInfoResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
