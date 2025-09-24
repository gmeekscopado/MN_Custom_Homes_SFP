/**
 * @description Helper class for MN Custom Homes operations
 * @author MN Custom Homes Development Team
 * @date 2025-09-24
 * @group Utility Classes
 * Used to demonstrate Copado deployment processes and business logic
 */
public with sharing class MNCustomHomesHelper {
    
    /** 
     * @description Base cost per square foot for luxury homes
     */
    private static final Decimal BASE_COST_PER_SQFT = 200.0;
    
    /** 
     * @description Premium markup percentage for custom features
     */
    private static final Decimal PREMIUM_MARKUP = 0.20;
    
    /** 
     * @description Minimum project duration in days
     */
    private static final Integer MIN_PROJECT_DAYS = 180;

    /**
     * @description Calculates project budget based on square footage
     * @param squareFootage The square footage of the home
     * @return Decimal estimated budget for the project
     * @example
     * Decimal budget = MNCustomHomesHelper.calculateProjectBudget(2500);
     */
    public static Decimal calculateProjectBudget(Decimal squareFootage) {
        // Input validation with proper null and boundary checks
        if (squareFootage == null || squareFootage <= 0) {
            return 0;
        }

        // Base calculation using constant
        Decimal baseCost = squareFootage * BASE_COST_PER_SQFT;

        // Add premium for custom features using constant
        Decimal premiumCost = baseCost * PREMIUM_MARKUP;

        return baseCost + premiumCost;
    }

    /**
     * @description Validates construction timeline for project feasibility
     * @param startDate Project start date
     * @param endDate Project end date
     * @return Boolean true if timeline is valid, false otherwise
     * @example
     * Boolean isValid = MNCustomHomesHelper.validateTimeline(Date.today(), Date.today().addDays(200));
     */
    public static Boolean validateTimeline(Date startDate, Date endDate) {
        // Comprehensive input validation
        if (startDate == null || endDate == null) {
            return false;
        }

        // Logical date order validation
        if (endDate <= startDate) {
            return false;
        }

        // Minimum project duration validation using constant
        Integer daysDifference = startDate.daysBetween(endDate);
        return daysDifference >= MIN_PROJECT_DAYS;
    }
    
    /**
     * @description Gets the base cost per square foot constant
     * @return Decimal base cost per square foot
     */
    public static Decimal getBaseCostPerSqft() {
        return BASE_COST_PER_SQFT;
    }
    
    /**
     * @description Gets the premium markup percentage
     * @return Decimal premium markup as decimal
     */
    public static Decimal getPremiumMarkup() {
        return PREMIUM_MARKUP;
    }
}