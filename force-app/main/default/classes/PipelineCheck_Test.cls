@isTest
public class PipelineCheck_Test {
    @isTest
    static void testPipelineCheckMethod() {

        Test.startTest();

        PipelineCheck.PipelineCheckMethod();

        Test.stopTest();

        List<Account> accounts = [SELECT Id FROM Account];
        System.assertEquals(1, accounts.size(), 'An account should have been inserted.');
    }
}
