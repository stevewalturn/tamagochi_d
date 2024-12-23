enum PetAction {
  feed(cost: 10, description: 'Feed your pet'),
  play(cost: 5, description: 'Play with your pet'),
  clean(cost: 15, description: 'Clean your pet'),
  heal(cost: 30, description: 'Heal your pet'),
  sleep(cost: 0, description: 'Let your pet sleep');

  final int cost;
  final String description;

  const PetAction({
    required this.cost,
    required this.description,
  });

  bool canAfford(int coins) => coins >= cost;
}
