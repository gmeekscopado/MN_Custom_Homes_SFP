/**
 * Helper class for MN Custom Homes operations
 * Used to demonstrate Copado deployment processes
 */
public class MNCustomHomesHelper {
    
    /**
     * Calculates project budget based on square footage
     * @param squareFootage The square footage of the home
     * @return Decimal estimated budget
     */
    public static Decimal calculateProjectBudget(Decimal squareFootage) {
        if (squareFootage == null || squareFootage <= 0) {
            return 0;
        }
        
        // Base calculation: $200 per square foot for luxury homes
        Decimal baseCost = squareFootage * 200;
        
        // Add premium for custom features (20% markup)
        Decimal premiumCost = baseCost * 0.20;
        
        return baseCost + premiumCost;
    }
    
    /**
     * Validates construction timeline
     * @param startDate Project start date
     * @param endDate Project end date
     * @return Boolean true if timeline is valid
     */
    public static Boolean validateTimeline(Date startDate, Date endDate) {
        if (startDate == null || endDate == null) {
            return false;
        }
        
        if (endDate <= startDate) {
            return false;
        }
        
        // Minimum project duration: 6 months
        Integer daysDifference = startDate.daysBetween(endDate);
        return daysDifference >= 180;
    }
}