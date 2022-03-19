abstract class AppUser {
  String id;
  //UserType userType;

  AppUser(this.id);

  Stream<AppUser?> get self;
}
