public with sharing class BatchExternalIdsPopulate_Sched {


    private static final Map<String, Map<String, String>> confMap = new Map<String, Map<String, String>>{
        'Product2' => new Map<String, String>{
            'externalIdFieldName' => 'Origin__c',
            'prefix' => 'PR'
        },
        'PriceBook2' => new Map<String, String>{
            'externalIdFieldName' => 'Origin__c',
            'prefix' => 'PB'
        },
        'PriceBookEntry' => new Map<String, String>{
            'externalIdFieldName' => 'Origin__c',
            'prefix' => 'PE'
        }
    };

    public BatchExternalIdsPopulate_Sched() {
        for(String obj : confMap.keySet()){
            BatchExternalIdsPopulate batch = new BatchExternalIdsPopulate(obj, confMap.get(obj).get('externalIdFieldName'),confMap.get(obj).get('prefix'));
            Database.executeBatch(batch, 100);
        }
    }
}