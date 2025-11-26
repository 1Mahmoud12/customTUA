class EndPoints {
  static const domain = 'https://tua01jo2025api.dev2.dot.jo';
  static const storage = 'https://whatsapp.buildererp.net/';
  static const baseUrl = '$domain/v1/';
  static const chatBaseUrl = 'user/whatsapp';

  // Auth
  static const countryCodes = 'Account/CountryCodes';
  static const register = 'user/register';
  static const login = 'user/login';
  static const utilitiesLookup = 'utilities/lookup';
  static const validateOTP = 'Account/ValidateOTP';
  static const updateFcmToken = 'Account/UpdateFCMToken';
  static const appVisit = 'AppSetting/Admin_UpdateAppVisit';
  static const forgetPassword = 'Account/ForgetPassword';
  static const resetPassword = 'user/set-password';
  static const resendOtp = 'Account/ResendOtp';
  static const deleteUser = 'Account/DeleteUser';
  static const requestResetPassword = 'user/request-reset-password';

  //home page

  static const homeCards = 'user/dashboard/widgets';
  static const statistics = 'user/dashboard/statistics';

  // store page
  static const hasStore = 'user/shops/check';
  static const storePageCards = 'user/shops/dashboard/widgets';
  static const topProduct = 'user/shops/dashboard/top-products';
  static const themeDetailsData = 'user/shops';
  static const allThemes = 'user/themes';
  static const countries = 'user/countries';
  static const states = 'user/states';
  static const cities = 'user/cities';
  static const orders = 'user/orders';
  static const graph = 'user/shops/dashboard/statistics';
  static const homeStatistics = 'user/dashboard/statistics';
  static const labels = 'user/labels';
  static const createStore = 'user/shops';
  static const checkSubdomain = 'user/shops/check-sub-domain-exists';
  static const brand = 'user/brands';
  static const getMessage = 'user/chats/get-messages-history';
  static const getHistoryMessage = 'user/chats/get-chat-history';
  static const sendAiMessage = 'user/chats/message';
  static const product = 'user/products';
  static const productReviews = 'user/product-reviews';
  static const availableSubCategories = 'user/products?filter[categories][]=';
  static const availableProduct = 'user/sub-categories?filter[parent_id]=';
  static const taxes = 'user/taxes';
  static const subCategories = 'user/sub-categories';
  static const categories = 'user/categories';
  static const ticketCategories = 'user/ticket-categories';
  static const getAllTickets = 'user/tickets';
  static const getAllTicketComments = 'user/ticket-comments';
  static const addTicketComment = 'user/ticket-comments';
  static const additionalFields = 'user/additional-fields';
  static const addClient = 'user/contacts';
  static const addGroup = 'user/groups';
  static const getTeams = 'user/teams';
  static const getTeamInvites = 'user/team-invites';
  static const getMessagesTemplate = 'user/template';

  // EditProfile
  static const editProfile = 'Account/EditProfile';

  // static const changePassword = 'Account/ChangePassword';
  static const editPhoneNmber = 'Account/EditPhoneNmber';
  static const validateOTPChangePhone = 'Account/ValidateOTPChangePhone';

  // Address
  static const addAddress = 'Address/AddUserAddress';
  static const editAddress = 'Address/EditUserAddress';
  static const deleteUserAddress = 'Address/DeleteUserAddress';
  static const getUserAddresses = 'Address/UserAddresses';
  static const setDefaultAddress = 'Address/SetDefaultAddresses';

  // Home
  static const getAllSlider = 'utilities/bms-by-category';
  static const staticPage = 'StaticPage/StaticPage';
  static const getAdvertises = 'Advertise/GetAdvertises';
  static const String getCurrency = 'user/get-currency';
  static const getBasicPage = 'utilities/basic-page';

  //  Service
  static const getCategories = 'Service/GetCategories';
  static const getAllServices = 'Service/GetAllServices';
  static const getAllPetPackages = 'Service/GetAllPetPackages';

  //Notification
  static const userNotifications = 'Notification/AllUserNotifications';
  static const readAllNotification = 'Notification/ReadAllUserNotification';
  static const notificationsCount = 'Notification/NotificationsUserCount';
  static const readNotification = 'Notification/ReadNotification';

  //Inbox
  static const getInbox = 'Notification/UserNotifications';
  static const deleteUserInbox = 'Notification/DeleteNotificationByUser';
  static const InboxCount = 'Notification/NotificationsCount';
  static const readInbox = 'Notification/ReadNotification';
  static const readAllInbox = 'Notification/ReadAllNotification';

  //Order
  static const userWallet = 'Order/UserWallet';
  static const getMyOrders = 'Order/GetMyOrders';
  static const getMyRefundOrder = 'Order/GetMyRefundOrders';
  static const getMyCanceledOrders = 'Order/GetMyCanceledOrders';
  static const getOrderDetails = 'Order/GetOrderDetails';
  static const getOrderHistory = 'Order/GetOrderHistory';

  // Cart
  static const addToCart = 'cart/add';
  static const getCartItems = 'cart/list';
  static const deleteCartItem = 'cart/delete';
  static const orderPaymentMethods = 'Order/OrderPaymentMethods';
  static const getOrderInvoice = 'Order/GetOrderInvoice';
  static const proceedOrder = 'Order/ProccedOrder';
  static const timeSlotListPerDay = 'TimeSlot/TimeSlotListPerDay';
  static const addFeedbackList = 'Order/AddFeedbackList';
  static const submitCancellationRequest = 'Order/SubmitCancellationRequest';
  static const getOrderVisitTime = 'Order/GetOrderVisitTime';
  static const increaseCartItem = 'cart/increment';
  static const decreaseCartItem = 'cart/decrement';
  static const checkoutAsVisitor = 'cart/guest-donor';
  static const verifyOtp = 'cart/verify-otp';
  static const hyperPayCheckout = 'cart/hyperpay-checkout';
  static const hyperPayHandler = 'cart/hyperpay-handler';

  //Claims
  static const addClaimMessage = 'ClaimMessage/AddClaimMessage';
  static const getClaimByUser = 'ClaimMessage/GetClaimByUser';

  // Announcements
  static const getAnnouncements = 'Announcements/AnnouncementUserList';
  static const deleteUserAnnouncement = 'Announcements/DeleteUserAnnouncement';
  static const readAnnouncement = 'Announcements/ReadAnnouncment';
  static const readAllAnnouncements = 'Announcements/ReadAllAnnouncments';

  // Contact us
  static const contactUs = 'SocialMedia/GetAllActiveSocialMedia';

  //chat
  static const chats = '$chatBaseUrl/get-chats/';
  static const messages = '$chatBaseUrl/get-messages-by-chatID';
  static const loadChatMedia = '$chatBaseUrl/load-chat-details-by-chat-id';
  static const sendMessage = '$chatBaseUrl/whatsapp/send-message';
  static const muteChat = '$chatBaseUrl/mute-chat';
  static const unMuteChat = '$chatBaseUrl/unmute-chat';

  // Delivery BOy
  static const getDeliveryBoys = 'user/delivery-boy';

  // update profile
  static const changePassword = 'user/change-password';
  static const updateProfile = 'user/update-profile';
  static const getProfileInfo = 'user/get-user-info';

  //donations
  static const getDonationPrograms = 'utilities/donation-programs';
  static const getDonationProgramById = 'utilities/donation-program-by-id';
  static const getProgramsTag = 'utilities/programs-tag';
  static const getDonationsTypes = 'utilities/donation-types';

  //e-cards
  static const getECards = 'utilities/e-cards';
  static const sendECard = 'utilities/send-ecard';

  //volunteering
  static const getVolunteeringPrograms = 'utilities/volunteering-programs';
  static const getVolunteeringProgramById = 'utilities/volunteering-program-by-id';
  static const createDonationCampaign = 'utilities/donation-campaign';
}
