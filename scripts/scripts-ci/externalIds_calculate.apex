private static final Map<String, Map<String, String>> confMap = new Map<String, Map<String, String>>{
    'Product2' => new Map<String, String>{
        'externalIdFieldName' => 'Origin__c',
        'prefix' => 'PRD'
    },
    'PriceBook2' => new Map<String, String>{
        'externalIdFieldName' => 'Origin__c',
        'prefix' => 'PBK'
    },
    'PriceBookEntry' => new Map<String, String>{
        'externalIdFieldName' => 'Origin__c',
        'prefix' => 'PBE'
    }
};


for(String obj : confMap.keySet()){
    BatchExternalIdsPopulate batch = new BatchExternalIdsPopulate(obj, confMap.get(obj).get('externalIdFieldName'),confMap.get(obj).get('prefix'));
    Database.executeBatch(batch, 100);
}