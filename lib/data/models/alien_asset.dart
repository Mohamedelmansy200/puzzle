import 'package:equatable/equatable.dart';

const aliensAssets = <AlienAsset>[
  AlienAsset('assets/img/tiles/krabs.png', 'krabs'),
  AlienAsset('assets/img/tiles/sandy.png', 'sandy'),
  AlienAsset('assets/img/tiles/spongebob.png', 'spongebob'),
  AlienAsset('assets/img/tiles/gary.png', 'gary'),
  AlienAsset('assets/img/tiles/sandy2.png', 'sandy2'),
  AlienAsset('assets/img/tiles/happy_spongebob.png', 'happy spongebob'),
  AlienAsset('assets/img/tiles/patrick.png', 'patrick'),
  AlienAsset('assets/img/tiles/squidward.png', 'squidward'),
  AlienAsset('assets/img/tiles/squidward2.png', 'squidward2'),
];

class AlienAsset extends Equatable {
  const AlienAsset(this.assetPath, this.name);

  final String assetPath;
  final String name;

  @override
  List<Object?> get props => [assetPath, name];
}
