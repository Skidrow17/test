global class BatchExternalIdsPopulate implements Database.Batchable<SObject> {
    private String objectName;
    private String originIdField;
    private String prefix;

    global BatchExternalIdsPopulate(String objectName, String originIdField, String prefix) {
        this.objectName = objectName;
        this.originIdField = originIdField;
        this.prefix = prefix;
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM ' + objectName + ' WHERE ' + originIdField + ' = NULL';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        for (SObject record : scope) {
            String modifiedId = prefix +'-'+ record.get('Id').toString().substring(3).toUpperCase(); 
            record.put(originIdField, modifiedId);
        }
        update scope;
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Batch job completed successfully.');
    }
}
