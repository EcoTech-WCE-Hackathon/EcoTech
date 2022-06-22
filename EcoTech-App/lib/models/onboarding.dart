class Onboarding {
  String image;
  String description;

  Onboarding({required this.image, required this.description});
}

List<Onboarding> onboardingContent = [
  Onboarding(
    image: 'images/ecotech-1.png',
    description: "The one-stop e-waste management solution.",
  ),
  Onboarding(
    image: 'images/ecotech-2.png',
    description: "Report e-waste and earn rewards.",
  ),
];
