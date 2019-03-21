Class Batch.Example.Product Extends %Persistent
{

Property ID As %String;

Property Name As %String;

Index IDKey On ID [ IdKey ];

Storage Default
{
<Data name="ProductDefaultData">
<Subscript>"1"</Subscript>
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<Data name="ProductState">
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^Batch.Example.ProductD</DataLocation>
<DefaultData>ProductDefaultData</DefaultData>
<IdLocation>^Batch.Example.ProductD</IdLocation>
<IndexLocation>^Batch.Example.ProductI</IndexLocation>
<State>ProductState</State>
<StreamLocation>^Batch.Example.ProductS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
