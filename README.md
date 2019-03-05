# BatchSqlOutboundAdapter

Extend EnsLib.SQL.OutboundAdapter to add batch support batch on JDBC connection.

ENSDEMO port to IRIS without HL7 and DICOM examples

## Prerequisites

Can be used on IRIS or Ensemble 2017.2+.

### Installing

Clone this repository

```
git clone https://github.com/grongierisc/BatchSqlOutboundAdapter.git
```

Use Batch.SQL.BatchSqlOutboundAdapter adaptor.

### Content of this project

This adaptor include :

* Batch.SQL.Common
  * No modification, simple extend of EnsLib.SQL.Common
* Batch.SQL.CommonJ
  * No modification, simple extend of EnsLib.SQL.CommonJ
* Batch.SQL.GatewayResultSet
  * Extension of EnsLib.SQL.GatewayResultSet to gain the ablility to use fetch size.
* Batch.SQL.JDBCGateway
  * Use to allow compilation and support on Ensemble 2017.1 and lower
* Batch.SQL.OutboundAdapter
  * The new adaptor with :
    * ExecuteQueryBatchParmArray allow SQL query a distant database and specify the JDBC fetchSize
    * ExecuteUpdateBatchParamArray allow insertion in a distant database with JDBC addBatch and executeBatch
* Batch.SQL.Snapshot
  * Extend of EnsLib.SQL.Snapshot to handle Batch.SQL.GatewayResultSet and the fetch size property
