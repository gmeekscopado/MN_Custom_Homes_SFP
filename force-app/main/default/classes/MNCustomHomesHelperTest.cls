/**
 * Test class for MNCustomHomesHelper
 * Demonstrates comprehensive test coverage for Copado deployment
 */
@isTest
public class MNCustomHomesHelperTest {
    
    @testSetup
    static void setupTestData() {
        // Create test material requests
        List<Material_Request__c> testRequests = new List<Material_Request__c>();
        
        testRequests.add(new Material_Request__c(
            Request_Type__c = 'Lumber',
            Status__c = 'Draft'
        ));
        
        testRequests.add(new Material_Request__c(
            Request_Type__c = 'Concrete',
            Status__c = 'Submitted'
        ));
        
        insert testRequests;
    }
    
    @isTest
    static void testCalculateProjectBudget_ValidSquareFootage() {
        Test.startTest();
        
        // Test with valid square footage
        Decimal result = MNCustomHomesHelper.calculateProjectBudget(2000);
        
        Test.stopTest();
        
        // Base: 2000 * $200 = $400,000
        // Premium: $400,000 * 0.20 = $80,000
        // Total: $480,000
        System.assertEquals(480000, result, 'Budget calculation should be correct for 2000 sq ft');
    }
    
    @isTest
    static void testCalculateProjectBudget_InvalidInput() {
        Test.startTest();
        
        // Test with null input
        Decimal resultNull = MNCustomHomesHelper.calculateProjectBudget(null);
        
        // Test with zero input
        Decimal resultZero = MNCustomHomesHelper.calculateProjectBudget(0);
        
        // Test with negative input
        Decimal resultNegative = MNCustomHomesHelper.calculateProjectBudget(-100);
        
        Test.stopTest();
        
        System.assertEquals(0, resultNull, 'Null input should return 0');
        System.assertEquals(0, resultZero, 'Zero input should return 0');
        System.assertEquals(0, resultNegative, 'Negative input should return 0');
    }
    
    @isTest
    static void testValidateTimeline_ValidDates() {
        Test.startTest();
        
        Date startDate = Date.today();
        Date endDate = Date.today().addDays(200); // 200 days (> 180 minimum)
        
        Boolean result = MNCustomHomesHelper.validateTimeline(startDate, endDate);
        
        Test.stopTest();
        
        System.assertEquals(true, result, 'Valid timeline should return true');
    }
    
    @isTest
    static void testValidateTimeline_InvalidDates() {
        Test.startTest();
        
        Date startDate = Date.today();
        
        // Test with null dates
        Boolean resultNullStart = MNCustomHomesHelper.validateTimeline(null, startDate.addDays(200));
        Boolean resultNullEnd = MNCustomHomesHelper.validateTimeline(startDate, null);
        
        // Test with end date before start date
        Boolean resultEndBeforeStart = MNCustomHomesHelper.validateTimeline(startDate, startDate.addDays(-10));
        
        // Test with timeline too short (< 180 days)
        Boolean resultTooShort = MNCustomHomesHelper.validateTimeline(startDate, startDate.addDays(100));
        
        Test.stopTest();
        
        System.assertEquals(false, resultNullStart, 'Null start date should return false');
        System.assertEquals(false, resultNullEnd, 'Null end date should return false');
        System.assertEquals(false, resultEndBeforeStart, 'End before start should return false');
        System.assertEquals(false, resultTooShort, 'Timeline too short should return false');
    }
    
    @isTest
    static void testMaterialRequestIntegration() {
        Test.startTest();
        
        // Query test material requests
        List<Material_Request__c> requests = [SELECT Id, Request_Type__c, Status__c FROM Material_Request__c];
        
        Test.stopTest();
        
        System.assertEquals(2, requests.size(), 'Should have 2 test material requests');
        System.assertNotEquals(null, requests[0].Request_Type__c, 'Request type should be populated');
    }
}