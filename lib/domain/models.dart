class SliderObject{
  String title;
  String supTitle;
  String image;


  SliderObject(this.title, this.supTitle, this.image);
}
class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
class Customer{

  String id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);

}
class Contact{
  String email;
  String link;
  String phone;
  Contact(this.email, this.link, this.phone);
}
class Authentication{
  Customer? customer;
  Contact? contacts;
  Authentication(this.customer, this.contacts) ;
}