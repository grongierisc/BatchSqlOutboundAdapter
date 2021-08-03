Class Example.Msg.Info Extends (%Persistent, %XML.Adaptor)
{

Property ID As %String;

Property ProductName As %String;

Property "Date_Alimentation" As %String;

Storage Default
{
<Data name="InfoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ID</Value>
</Value>
<Value name="3">
<Value>ProductName</Value>
</Value>
<Value name="4">
<Value>Date_Alimentation</Value>
</Value>
</Data>
<DataLocation>^Example.Msg.InfoD</DataLocation>
<DefaultData>InfoDefaultData</DefaultData>
<IdLocation>^Example.Msg.InfoD</IdLocation>
<IndexLocation>^Example.Msg.InfoI</IndexLocation>
<StreamLocation>^Example.Msg.InfoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
