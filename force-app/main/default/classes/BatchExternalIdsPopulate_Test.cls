@isTest
private class BatchExternalIdsPopulate_Test {
    @testSetup
    static void setupTestData() {
        List<Product2> products = new List<Product2>();
        for (Integer i = 0; i < 5; i++) {
            products.add(new Product2(Name = 'Test Product ' + i, OriginId__c = null));
        }
        insert products;
    }

    @isTest
    static void testBatchExecution() {
        List<Product2> productsBefore = [SELECT Id, OriginId__c FROM Product2 WHERE OriginId__c = NULL];
        System.assertEquals(5, productsBefore.size(), 'There should be 5 products with OriginId__c null before batch runs.');

        Test.startTest();
        BatchExternalIdsPopulate batchJob = new BatchExternalIdsPopulate('Product2', 'OriginId__c', 'PRD');
        Database.executeBatch(batchJob, 200);
        Test.stopTest();

        List<Product2> productsAfter = [SELECT Id, OriginId__c FROM Product2 WHERE Id IN :productsBefore];
        for (Product2 prod : productsAfter) {
            System.assertNotEquals(null, prod.OriginId__c, 'OriginId__c should be populated.');
            System.assert(prod.OriginId__c.startsWith('PRD-'), 'OriginId__c should start with "PRD-"');
        }
    }
}
