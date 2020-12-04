class FuelCalculator {
  double calculateCost(double distance, double distancePerUnit, double price) {
    return distance / distancePerUnit * price;
  }
}
