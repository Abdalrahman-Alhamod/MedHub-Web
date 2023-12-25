import 'package:get/get.dart';

class AppLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          // start
          "welcomeMessage": "أهلاً بعودتك",

          // auth
          "enterCredentials": "من فضلك أدخل بياناتك الائتمانية",
          "signIn": "تسجيل الدخول",
          "userNumber": "رقم المستخدم",
          "password": "كلمة المرور",
          "notAMember": " لست عضواً؟ ",
          "alreadyHaveAnAccount": "تملك حساباً مسبقاً؟ ",
          "register": "إنشاء حساب",
          "signUp": "التسجيل",
          "pharmacyName": "اسم الصيدلية",
          "userName": "اسم المستخدم",
          "confirmPassword": "تأكيد كلمة المرور",
          "fieldIsRequired": "هذا الحقل مطلوب",
          "phoneNumberShouldStart": "رقم الهاتف يجب أن يبدأ ب 09",
          "phoneNumberLength": "يجب أن يتألف رقم الهاتف من 10 خانات",
          "enterValidNumber": "من فضلك ادخل رقماً صالحاً",
          "passwordShouldBe8": "يجب أن تتألف كلمة المرور من 8 محارف على الأقل",
          "passwordsDontMatch": "كلمتا المرور لا تتطابقان",
          "letsCreateAnAccount": "لننشئ حساباً من أجلك",

          // snack bar messages
          "signedInSuccess": "تم تسجيل الدخول بنجاح !",
          "registerSuccess": "تم تسجيل الحساب بنجاح !",
          "logedOutSuccess": "تم تسجيل الخروج بنجاح !",
          "close": "أغلق",

          // botton nav bar
          "home": "الرئيسية",
          "search": "البحث",
          "cart": "المشتريات",
          "orders": "الطلبات",
          "favourite": "المفضلة",

          // product type
          "All": "الكل",
          "PainAndRelief": "مزيل الألم",
          "ColdAndFlu": "البرد و الأنفلونزا",
          "AllergyMedications": "أدوية الحساسية",
          "DigestiveHealth": "صحة الجهاز الهضمي",
          "CardiovascularMedications": "أدوية القلب و الأوعية",
          "Antibiotics": "مضادات حيوية",
          "DiabetesManagement": "إدارة مرض السكري",
          "DermatologicalProducts": "المنتجات الجلدية",
          "VitaminsAndSupplements": "الفيتامينات و المكملات الغذائية",
          "WomenHealth": "صحة المرأة",

          // product details cards
          "SP": "ل.س",
          "brand": "الشركة المصنعة",
          "expiration": "تاريخ الانتهاء",
          "inStock": "في المخزن",
          "category": "التصنيف",
          "addToCart": "أضف إلى السلة",
          "quantity": "الكمية :",
          "enterQuantity": "أدخل الكمية :",
          "add": "أضف",
          "cancel": "إلغاء",
          "confirm": "تأكيد",
          "addedSuccessfully": "تمت الإضافة بنجاح !",
          "unavailable": "غير متوفر",
          "Delete": "حذف",
          "Edit Information": "تعديل المعلومات",
          "Product Deleted Successfully !": "تم حذف المنتج بنجاح !",
          "Delete Product": "حذف منتج",
          "Are you sure you want to delete the product with id ":
              "هل أنت متأكد أنك تريد حذف المنتج ذو المعرف ",

          // Product List View
          "searchFor": "ابحث عن",
          "categories": "التصنيفات :",
          "mostPopular": "الأكثر شهرة :",
          "recentlyAdd": "المضاف حديثاً :",

          // Api
          "networkError": "خطأ في الاتصال !",
          "connectionTimeOut": "انتهت مهلة الاتصال !",
          "somthingWrongHappend": "حدث خطأ ما! ",
          "loading": "جارِ التحميل...",

          // Cart
          "purchase": "شراء",
          "purchaseSuccessful": "تم الشراء بنجاح !",
          "totalPrice": "السعر الإجمالي : ",
          "confirmPurchase": "تأكيد الشراء",
          "youOrderTotalPriceIs": "السعر الإجمالي لطلبك هو ",
          "addedToCartSuccessfully": "تمت الإضافة إلى السلة بنجاح !",
          "failedToAddToTheCart": "فشل في الإضافة إلى السلة !",

          // test products
          "Amoxil": "اموكسيل",
          "Amoxicillin": "أموكسيسيلين",
          "GlaxoSmithKline": "جلاكسو سميث كلاين",
          "desc":
              "أموكسيل هو مضاد حيوي من البنسلين، يعطى لعلاج الالتهابات التي تسببها البكتيريا",

          // Orders
          "All Orders": "كل الطلبات",
          "preparing": "قيد التحضير",
          "delivering": "يتم التوصيل",
          "recieved": "تم الاستلام",
          "refused": "تم الرفض",
          "Payed":"مدفوع",
          "Not Payed":"غير مدفوع",
          "orderID": "معرف الطلب :",
          "totalBill": "المبلغ الإجمالي :",
          "status": "الحالة :",
          "date": "التاريخ :",
          "pc": "ق",
          "orderDetails": "تفاصيل الطلب",
          "Pharmacist Name": "اسم الصيدلي :",
          "Pharmacy Name": "اسم الصيدلية :",
          "Change Order Status":"تغيير حالة الطلب :",
          "Change Payment Statues":"تغيير حالة الدفع :",

          // User
          "statistics": "الإحصائيات",
          "language": "لغة التطبيق",
          "logout": "تسجيل الخروج",
          "selectLangauge": "اختر لغة التطبيق",
          "english": "الإنكليزية",
          "arabic": "العربية",

          // Search By
          "searchBy": "البحث عن طريق : ",
          "name": "الاسم التجاري",
          "scientificName": "الاسم العلمي",
          "description": "الوصف",

          // Statitics
          "Data Highlights": "أبرز البيانات",
          "Orders": "الطلبات",
          "Total Paid": "مجموع المبالغ المدفوعة",
          "Medicines": "الأدوية",
          "Favorites": "المفضلة",
          "Top Purchased Categories": "أهم الفئات التي تم شراؤها",
          "Weekly Expense": "المصروف الأسبوعي",

          // Add product
          "Value must be greate than zero":
              "يجب أن تكون القيمة أكبر تماماً من الصفر",
          "Profit must be smaller than price":
              "يجب أن يكون الربح أصغر من السعر",
          "Category is required !": "فئة المنتج مطلوبة !",
          "Date is required !": "التاريخ مطلوب !",
          "Image is required !": "الصورة مطلوبة !",
          "Product Added Successfully !": "تمت إضافة المنتج بنجاح",
          "Add Product": "إضافة منتج",
          "English Name": "الاسم التجاري بالإنكليزية",
          "English Scientific Name": "الاسم العلمي بالإنكليزية",
          "English Description": "الوصف بالإنكليزية",
          "English Brand Name": "اسم الشركة بالإنكليزية",
          "Arabic Name": "الاسم التجاري بالعربية",
          "Arabic Scientific Name": "الاسم العلمي بالعربية",
          "Arabic Description": "الوصف بالعربية",
          "Arabic Brand Name": "اسم الشركة بالعربية",
          "Price": "السعر",
          "Profit": "الربح",
          "Quantity": "الكمية",
          "Product Category": "فئة المنتج",
          "Expiration Date": "تاريخ انتهاء الصلاحية",
          "Product Image": "صورة المنتج",
          "Add": "إضافة",
        },
        "en": {
          //start
          "welcomeMessage": "Welcome back",

          // auth
          "enterCredentials": "Please enter your credentials to Login",
          "signIn": "Sign in",
          "userNumber": "User Number",
          "password": "Password",
          "alreadyHaveAnAccount": "Already have an account? ",
          "register": "Register",
          "notAMember": "Not a member? ",
          "signUp": "Sign up",
          "pharmacyName": "Pharmacy Name",
          "userName": "User Name",
          "confirmPassword": "Confirm Password",
          "fieldIsRequired": "Field is required",
          "phoneNumberShouldStart": "Phone number should start with 09",
          "phoneNumberLength": "Phone number length should be 10 digits",
          "enterValidNumber": "Please enter a valid number",
          "passwordShouldBe8": "Password should be at least 8 characters",
          "passwordsDontMatch": "Passwords don't match",
          "letsCreateAnAccount": "Let's create an account for you",

          // snack bar messages
          "signedInSuccess": "Signed in successfully !",
          "registerSuccess": "Signed up successfully !",
          "logedOutSuccess": "Logged out successfully !",
          "close": "Close",

          // botton nav bar
          "home": "Home",
          "search": "Search",
          "cart": "Cart",
          "orders": "Orders",
          "favourite": "Favourite",

          // product type
          "All": "All",
          "PainAndRelief": "Pain And Relief",
          "ColdAndFlu": "Cold And Flu",
          "AllergyMedications": "Allergy Medications",
          "DigestiveHealth": "Digestive  Health",
          "CardiovascularMedications": "Cardiovascular Medications",
          "Antibiotics": "Antibiotics",
          "DiabetesManagement": "Diabetes Management",
          "DermatologicalProducts": "Dermatological Products",
          "VitaminsAndSupplements": "Vitamins And Supplements",
          "WomenHealth": "Women Health",

          // product details cards
          "SP": "SP",
          "brand": "Brand",
          "expiration": "Expiration",
          "inStock": "In Stock",
          "category": "Category",
          "addToCart": "Add To Cart",
          "quantity": "Quantity :",
          "enterQuantity": "Enter Quantity :",
          "add": "Add",
          "cancel": "Cancel",
          "confirm": "Confirm",
          "addedSuccessfully": "Added Successfully !",
          "unavailable": "Unavailable",
          "Delete": "Delete",
          "Edit Information": "Edit Information",
          "Delete Product": "Delete Product",
          "Are you sure you want to delete the product with id ":
              "Are you sure you want to delete the product with id ",

          // Product List View
          "searchFor": "Search for",
          "categories": "Categories :",
          "mostPopular": "Most popular :",
          "recentlyAdd": "Recently added :",

          // Api
          "networkError": "Network Error!",
          "connectionTimeOut": "Connection time out!",
          "somthingWrongHappend": "Something wrong happend!",
          "loading": "Loading...",

          // Cart
          "purchase": "Purchase",
          "purchaseSuccessful": "Purchased Successfully !",
          "totalPrice": "Total Price : ",
          "confirmPurchase": "Confirm Purchase",
          "youOrderTotalPriceIs": "Your order total price is ",
          "addedToCartSuccessfully": "Added to cart successfully !",
          "failedToAddToTheCart": "Failed to add to the cart !",

          // test products
          "Amoxil": "Amoxil",
          "Amoxicillin": "Amoxicillin",
          "GlaxoSmithKline": "GlaxoSmithKline",
          "desc":
              "Amoxil is a penicillin antibiotic, which is given to treat the infections caused by bacteria",

          // Orders
          "All Orders":"All Orders",
          "preparing": "Preparing",
          "delivering": "Delivering",
          "recieved": "Recieved",
          "refused": "Refused",
          "Payed": "Payed",
          "Not Payed": "Not Payed",
          "orderID": "Order ID :",
          "totalBill": "Total Bill :",
          "status": "Status :",
          "date": "Date :",
          "pc": "pc",
          "orderDetails": "Order Details",
          "Pharmacist Name": "Pharmacist Name :",
          "Pharmacy Name": "Pharmacy Name :",
           "Change Order Status":"Change Order Status : ",
          "Change Payment Statues":"Change Payment Statues : ",

          // User
          "statistics": "Statistics",
          "language": "Language",
          "logout": "Logout",
          "selectLangauge": "Select Langauge",
          "english": "English",
          "arabic": "Arabic",

          // Search By
          "searchBy": "Search By : ",
          "name": "Name",
          "scientificName": "Scientific Name",
          "description": "Description",
          // Statitics
          "Data Highlights": "Data Highlights",
          "Orders": "Orders",
          "Total Paid": "Total Paid",
          "Medicines": "Medicines",
          "Favorites": "Favorites",
          "Top Purchased Categories": "Top Purchased Categories",
          "Weekly Expense": "Weekly Expense",

          // Add product
          "Value must be greate than zero": "Value must be greate than zero",
          "Profit must be smaller than price": "Profit must be less than price",
          "Category is required !": "Category is required !",
          "Date is required !": "Date is required !",
          "Image is required !": "Image is required !",
          "Product Added Successfully !": "Product Added Successfully !",
          "Add Product": "Add Product",
          "English Name": "English Name",
          "English Scientific Name": "English Scientific Name",
          "English Description": "English Description",
          "English Brand Name": "English Brand Name",
          "Arabic Name": "Arabic Name",
          "Arabic Scientific Name": "Arabic Scientific Name",
          "Arabic Description": "Arabic Description",
          "Arabic Brand Name": "Arabic Brand Name",
          "Price": "Price",
          "Profit": "Profit",
          "Quantity": "Quantity",
          "Product Category": "Product Category",
          "Expiration Date": "Expiration Date",
          "Product Image": "Product Image",
          "Add": "Add",
          "Product Deleted Successfully !": "Product Deleted Successfully !",
        },
      };
}
