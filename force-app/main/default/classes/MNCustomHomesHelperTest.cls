/**
 * @description Test class for MNCustomHomesHelper
 * @author MN Custom Homes Development Team
 * @date 2025-09-24
 * @group Test Classes
 * @see MNCustomHomesHelper
 */
@isTest
private class MNCustomHomesHelperTest {
    
    /**
     * @description Test data for square footage calculations
     */
    private static final Decimal TEST_SQUARE_FOOTAGE = 2500;
    
    /**
     * @description Test data for small square footage
     */
    private static final Decimal SMALL_SQUARE_FOOTAGE = 1000;
    
    /**
     * @description Expected budget for test square footage
     */
    private static final Decimal EXPECTED_BUDGET = 600000; // 2500 * 200 * 1.2
    
    /**
     * @description Test date for timeline validation
     */
    private static final Date TEST_START_DATE = Date.newInstance(2025, 1, 1);

    /**
     * @description Tests budget calculation with valid square footage
     */
    @isTest
    static void testCalculateProjectBudgetValid() {
        // Test: Valid square footage calculation
        Test.startTest();
        Decimal result = MNCustomHomesHelper.calculateProjectBudget(TEST_SQUARE_FOOTAGE);
        Test.stopTest();

        // Verify: Correct budget calculation (2500 * 200 * 1.2 = 600,000)
        System.assertEquals(EXPECTED_BUDGET, result, 'Budget calculation should be correct for valid square footage');
    }

    /**
     * @description Tests budget calculation with null input
     */
    @isTest
    static void testCalculateProjectBudgetNull() {
        // Test: Null square footage
        Test.startTest();
        Decimal result = MNCustomHomesHelper.calculateProjectBudget(null);
        Test.stopTest();

        // Verify: Returns zero for null input
        System.assertEquals(0, result, 'Budget should be zero for null square footage');
    }

    /**
     * @description Tests budget calculation with zero input
     */
    @isTest
    static void testCalculateProjectBudgetZero() {
        // Test: Zero square footage
        Test.startTest();
        Decimal result = MNCustomHomesHelper.calculateProjectBudget(0);
        Test.stopTest();

        // Verify: Returns zero for zero input
        System.assertEquals(0, result, 'Budget should be zero for zero square footage');
    }

    /**
     * @description Tests budget calculation with negative input
     */
    @isTest
    static void testCalculateProjectBudgetNegative() {
        // Test: Negative square footage
        Test.startTest();
        Decimal result = MNCustomHomesHelper.calculateProjectBudget(-100);
        Test.stopTest();

        // Verify: Returns zero for negative input
        System.assertEquals(0, result, 'Budget should be zero for negative square footage');
    }

    /**
     * @description Tests timeline validation with valid dates
     */
    @isTest
    static void testValidateTimelineValid() {
        // Setup: Valid timeline (200 days, minimum is 180)
        Date endDate = TEST_START_DATE.addDays(200);

        // Test: Valid timeline validation
        Test.startTest();
        Boolean result = MNCustomHomesHelper.validateTimeline(TEST_START_DATE, endDate);
        Test.stopTest();

        // Verify: Valid timeline returns true
        System.assertEquals(true, result, 'Valid timeline should return true');
    }

    /**
     * @description Tests timeline validation with insufficient duration
     */
    @isTest
    static void testValidateTimelineShort() {
        // Setup: Short timeline (100 days, minimum is 180)
        Date endDate = TEST_START_DATE.addDays(100);

        // Test: Short timeline validation
        Test.startTest();
        Boolean result = MNCustomHomesHelper.validateTimeline(TEST_START_DATE, endDate);
        Test.stopTest();

        // Verify: Short timeline returns false
        System.assertEquals(false, result, 'Timeline shorter than minimum should return false');
    }

    /**
     * @description Tests timeline validation with null start date
     */
    @isTest
    static void testValidateTimelineNullStart() {
        // Setup: Null start date
        Date endDate = TEST_START_DATE.addDays(200);

        // Test: Null start date validation
        Test.startTest();
        Boolean result = MNCustomHomesHelper.validateTimeline(null, endDate);
        Test.stopTest();

        // Verify: Null start date returns false
        System.assertEquals(false, result, 'Null start date should return false');
    }

    /**
     * @description Tests timeline validation with null end date
     */
    @isTest
    static void testValidateTimelineNullEnd() {
        // Test: Null end date validation
        Test.startTest();
        Boolean result = MNCustomHomesHelper.validateTimeline(TEST_START_DATE, null);
        Test.stopTest();

        // Verify: Null end date returns false
        System.assertEquals(false, result, 'Null end date should return false');
    }

    /**
     * @description Tests timeline validation with end date before start date
     */
    @isTest
    static void testValidateTimelineReversed() {
        // Setup: End date before start date
        Date endDate = TEST_START_DATE.addDays(-10);

        // Test: Reversed timeline validation
        Test.startTest();
        Boolean result = MNCustomHomesHelper.validateTimeline(TEST_START_DATE, endDate);
        Test.stopTest();

        // Verify: Reversed timeline returns false
        System.assertEquals(false, result, 'End date before start date should return false');
    }

    /**
     * @description Tests base cost per square foot getter
     */
    @isTest
    static void testGetBaseCostPerSqft() {
        // Test: Get base cost constant
        Test.startTest();
        Decimal result = MNCustomHomesHelper.getBaseCostPerSqft();
        Test.stopTest();

        // Verify: Returns expected base cost
        System.assertEquals(200.0, result, 'Base cost per square foot should be 200.0');
        System.assertNotEquals(null, result, 'Base cost should not be null');
    }

    /**
     * @description Tests premium markup getter
     */
    @isTest
    static void testGetPremiumMarkup() {
        // Test: Get premium markup constant
        Test.startTest();
        Decimal result = MNCustomHomesHelper.getPremiumMarkup();
        Test.stopTest();

        // Verify: Returns expected premium markup
        System.assertEquals(0.20, result, 'Premium markup should be 0.20 (20%)');
        System.assertNotEquals(null, result, 'Premium markup should not be null');
    }

    /**
     * @description Tests integration of constants with calculation method
     */
    @isTest
    static void testConstantsIntegration() {
        // Test: Verify constants are used correctly in calculations
        Test.startTest();
        Decimal baseCost = MNCustomHomesHelper.getBaseCostPerSqft();
        Decimal markup = MNCustomHomesHelper.getPremiumMarkup();
        Decimal calculatedBudget = MNCustomHomesHelper.calculateProjectBudget(SMALL_SQUARE_FOOTAGE);
        Test.stopTest();

        // Verify: Manual calculation matches method result
        Decimal expectedResult = SMALL_SQUARE_FOOTAGE * baseCost * (1 + markup);
        System.assertEquals(expectedResult, calculatedBudget, 'Constants should integrate correctly with calculation');
    }
}