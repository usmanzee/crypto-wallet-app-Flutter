const Map<String, String> en = {
  //General Messages
  'copy.to.clipboard': 'Copied to Clipboard',
  'logged_in': 'Logged In',
  'logged_out': 'Your login session has expired',
  'no.internet': 'No Internet connection',
  'server.not.available': 'Unable to communitate with the server',
  'server.error': 'Server Error',
  'server_exception': 'Something went wrong on the server side',

  //App Bottom Navbar
  'bottom.navbar.home': 'Home',
  'bottom.navbar.markets': 'Markets',
  'bottom.navbar.trading': 'Trading',
  'bottom.navbar.buy_sell': 'Buy/Sell',
  'bottom.navbar.wallets': 'Wallets',

  //App Login Screen
  'login.screen.field.email': 'Email',
  'login.screen.field.password': 'Password',
  'login.screen.email.error': 'Please type a valid email address',
  'login.screen.password.error':
      'Passwords must be 8 characters with uppercase and special letters',
  'login.screen.forget_password': 'Forget Password',
  'login.screen.button.login': 'Login',
  'login.screen.button.register': 'Register',

  //App Register Screen
  'register.screen.field.email': 'Email',
  'register.screen.field.password': 'Password',
  'register.screen.field.confirm_password': 'Confirm Password',
  'register.screen.field.referral_code': 'Referral Code',
  'register.screen.email.error': 'Please type a valid email address',
  'register.screen.password.error':
      'Passwords must be 8 characters with uppercase and special letters',
  'register.screen.confirm_password.error': 'Passwords do not match',
  'register.screen.button.register': 'Register',
  'register.screen.button.login': 'Login',

  //App Forget Password Screen
  'forget_password.screen.field.email': 'Email',
  'forget_password.screen.email.error': 'Please type a valid email address',
  'forget_password.screen.button.send_code': 'Send Verification Code',
  'forget_password.screen.button.login': 'Back to Login',

  //App Login/2FA Screen
  '2fa_login.screen.field.2fa': '2FA Code',
  '2fa_login.screen.email.error': 'Please enter a valid 2FA code',
  '2fa_login.screen.button.login': 'Login',

  //App Login/Verify Email Screen
  'verify_email.screen.title': 'Verify Your Email Address',
  'verify_email.screen.desc':
      'To complete registration, check for an email in your inbox with further instructions. If you cannot find the email, please check your spam folder.',
  'verify_email.screen.button.resend': 'Resend Confirmation',

  // App Settings Screen
  'account.screen.title': 'Account',
  'account.screen.fee_schedule': 'Fee Schedule',
  'account.screen.referral_id': 'Referral Id',
  'account.screen.identification': 'Identification',
  'account.screen.notifications': 'Notifications',
  'account.screen.security': 'Security',
  'account.screen.languages': 'Languages',
  'account.screen.help_support': 'Help & Support',
  'account.screen.share': 'Share the App',
  'account.screen.login_register': 'Login/Register',
  'account.screen.logout': 'Logout',

  //App Referral Screen
  'referral.screen.title': 'Referral',
  'referral.screen.referral_title': 'Invite Friends & Earn Crypto Together',
  'referral.screen.referral_description':
      'Earn up to 40% commission every time your friend makes a trade on B4U.',
  'referral.screen.referral_instruction.title': 'Invite Now',
  'referral.screen.referral_instruction.description':
      'Use your unique link to invite your friends over message or email. Your default invitation code can also be shared in real life or as a screenshot.',
  'referral.screen.referral_id': 'Referral ID',
  'referral.screen.referral_link': 'Referral Link',
  'referral.screen.referral_copy_id': 'Copy ID',
  'referral.screen.referral_copy_link': 'Copy Link',
  'referral.screen.share': 'Share',

  //App Notifications Screen
  'identification.screen.title': 'Verification',
  'identification.screen.phone.field.phone': 'Phone Number',
  'identification.screen.phone.button.send_code': 'Send Verification Code',
  'identification.screen.phone.alert': 'Alert',
  'identification.screen.phone.alert.desc':
      'A Pin has been sent to your phone number',
  'identification.screen.phone.field.pin': 'Pin Code',
  'identification.screen.phone.pin.error': 'Please enter a valid pin code',
  'identification.screen.phone.secs': 'Secs',
  'identification.screen.phone.button.resend': 'Resend Code',
  'identification.screen.phone.button.verify': 'Verify',

  //App Notifications Screen
  'notifications.screen.title': 'Notifications',
  'notifications.screen.empty.content1': "You're up to date!",
  'notifications.screen.empty.content2':
      'Visit every day for crypto news, price alerts, and more',
  'notifications.screen.detail.seen.button.text': 'I understand',

  //App Security Screen
  'security.screen.title': 'Security',
  'security.screen.twoFA': "2FA",
  'security.screen.twoFA_enable': "Enable",
  'security.screen.twoFA_disable': "Disable",
  'security.screen.password': "Password",
  'security.screen.password_change': "Change",
  'security.screen.password_button_text': "Change",
  'security.screen.disable.2fa.title': "Please Enter 2FA",
  'security.screen.disable.2fa.submit': "Submit",
  'security.screen.2fa_error': "Please enter a valid 2FA code",

  //App Security Enable 2FA Screen
  'security_enable2fa.screen.title': 'Two Factor Authentication',
  'security_enable2fa.screen.step1.title': 'Download & Install',
  'security_enable2fa.screen.step1.desc':
      'Download and install the Google Authenticator application from the App Store or Google play.',
  'security_enable2fa.screen.step2.title': 'Save The Serect Key',
  'security_enable2fa.screen.step2.desc':
      'Save this secret in a secure location. This code can be used to gain 2FA access from a different device.',
  'security_enable2fa.screen.step2.button.copy_secret': 'Copy Secret',
  'security_enable2fa.screen.step3.title': 'Verify The Secrect Key',
  'security_enable2fa.screen.step3.field.key':
      'Enter the 16-digit key you just backed up',
  'security_enable2fa.screen.step3.key.error': 'Key did not match',
  'security_enable2fa.screen.step4.title':
      'Submit the Code From Authenticator App',
  'security_enable2fa.screen.step4.desc':
      'Now create a new entry in your authenticator app with the saved secret key and verify the generated code.',
  'security_enable2fa.screen.step4.field.2fa':
      'Enter code from Google authenticator app',
  'security_enable2fa.screen.step4.2fa.error': 'Please enter a valid 2FA code',
  'security_enable2fa.screen.button.back': 'Back',
  'security_enable2fa.screen.button.next': 'Next',

  //App Change Password Screen
  'change.password.screen.title': "Change Password",
  'change.password.screen.field.old_password': "Old Password",
  'change.password.screen.field.new_password': "New Password",
  'change.password.screen.field.confirm_new_password': "Confirm New Password",
  'change.password.screen.change': "Change",
  'change.password.screen.password.error':
      "Passwords must be 8 characters with uppercase letters",
  'change.password.screen.password_confirm.error': "Passwords do not match",

  //App Home Screen
  'home.screen.link.card.deposit': 'Deposit',
  'home.screen.link.card.withdraw': 'Withdraw',
  'home.screen.link.card.buy_sell': 'Buy/Sell',
  'home.screen.link.card.trading': 'Trading',
  'home.screen.tabs.losers': 'Losers',
  'home.screen.tabs.gainers': 'Gainers',

  //App Markets Screen
  'markets.screen.title': 'Markets',
  'markets.screen.column.pair': 'Pair',
  'markets.screen.column.last_price': 'Last Price',
  'markets.screen.column.24hr_change': '24h Chg%',
  'markets.screen.vol': 'Vol',

  //App Market Detail Screen
  'market_detail.screen.high': 'High',
  'market_detail.screen.low': 'Low',
  'market_detail.screen.24hr': '24h',
  'market_detail.screen.vol': 'Vol',
  'market_detail.tabs.line': 'Line',
  'market_detail.tabs.depth': 'Depth',
  'market_detail.order_book': 'Order Book',
  'market_detail.button.buy': 'Buy',
  'market_detail.button.sell': 'Sell',

  //App Trading Screen
  'trading.screen.tabs.limit': 'Limit',
  'trading.screen.tabs.market': 'Market',
  'trading.screen.tab.limit.buy.field.price': 'Price',
  'trading.screen.tab.limit.buy.field.amount': 'Amount',
  'trading.screen.tab.limit.buy.field.total': 'Total (@currency)',
  'trading.screen.tab.limit.buy.available': 'Avbl',
  'trading.screen.tab.limit.buy.fee': 'Fee',
  'trading.screen.tab.limit.buy.button': 'Buy @currency',

  'trading.screen.tab.limit.sell.field.price': 'Price',
  'trading.screen.tab.limit.sell.field.amount': 'Amount',
  'trading.screen.tab.limit.sell.field.total': 'Total (@currency)',
  'trading.screen.tab.limit.sell.available': 'Avbl',
  'trading.screen.tab.limit.sell.fee': 'Fee',
  'trading.screen.tab.limit.sell.button': 'Sell @currency',

  'trading.screen.tab.market.buy.field.amount': 'Amount',
  'trading.screen.tab.market.buy.field.total': 'Total (@currency)',
  'trading.screen.tab.market.buy.available': 'Avbl',
  'trading.screen.tab.market.buy.fee': 'Fee',
  'trading.screen.tab.market.buy.button': 'Buy @currency',

  'trading.screen.tab.market.sell.field.amount': 'Amount',
  'trading.screen.tab.market.sell.field.total': 'Total (@currency)',
  'trading.screen.tab.market.sell.available': 'Avbl',
  'trading.screen.tab.market.sell.fee': 'Fee',
  'trading.screen.tab.market.sell.button': 'Sell @currency',

  //App Orderbook screen
  'order_book.screen.column.amount': 'Amount',
  'order_book.screen.column.price': 'Price',

  //App Openorders screen
  'open_order.screen.title': 'Open Orders',
  'open_order.screen.hide_pair': 'Hide Order Pairs',
  'open_order.screen.buy_limit': 'Buy Limit',
  'open_order.screen.sell_limit': 'Sell Limit',
  'open_order.screen.amount': 'Amount',
  'open_order.screen.price': 'Price',
  'open_order.screen.cancel_all.button': 'Cancel All',
  'open_order.screen.cancel.button': 'Cancel',

  //App Swap screen
  'swap.screen.title': 'Buy/Sell',
  'swap.screen.2fa_disabled': 'To Exchange, you have to enable 2FA',
  'swap.screen.2fa_disabled_button': 'Enable 2FA',
  'swap.screen.account_not_confirmed':
      'To Exchange, you have to confirm your account',
  'swap.screen.account_not_confirmed_button': 'Confirm Account',
  'swap.screen.field.from': 'From',
  'swap.screen.field.to': 'To',
  'swap.screen.amount.error1':
      'The amount has to be lower than @amount @currency',
  'swap.screen.amount.error2':
      'The amount has to be higher than @amount @currency',
  'swap.screen.amount.error3':
      'Your balance is not enough. Please fund your wallet',
  'swap.screen.available': 'Available',
  'swap.screen.max': 'Max',
  'swap.screen.button_preview': 'Preview Rates',
  'swap.screen.select.from': 'From',
  'swap.screen.select.to': 'To',
  'swap.screen.select.convert_from': 'Convert From',
  'swap.screen.select.convert_to': 'Convert To',
  'swap.screen.select.button.cancel': 'Cancel',
  'swap.screen.select.button.confirm': 'Confirm',
  'swap.screen.preview.confirm_conversion': 'Confirm Conversion',
  'swap.screen.preview.will_receive': 'You will receive',
  'swap.screen.preview.price': 'Price',
  'swap.screen.preview.fee': 'Fee',
  'swap.screen.preview.field.2fa': 'Enter 2FA code to proceed',
  'swap.screen.preview.2fa.error': 'Please enter a valid 2FA code',
  'swap.screen.preview.button.back': 'Back',
  'swap.screen.preview.button.convert': 'Convert',

  //App Swap History Screen
  'swap_history.screen.title': 'Buy/Sell History',
  'swap_history.screen.column.from': 'From',
  'swap_history.screen.column.to': 'To',

  //App Wallets Screen
  'wallets.screen.title': 'Wallets',
  'wallets.screen.equity_value': 'Equity Value',
  'wallets.screen.button.deposit': 'Deposit',
  'wallets.screen.button.withdraw': 'Withdraw',
  'wallets.screen.column.currency': 'Currency',
  'wallets.screen.column.amount': 'Amount',

  //App Wallet Detail Screen
  'wallet_detail.screen.total': 'Total',
  'wallet_detail.screen.available': 'Available',
  'wallet_detail.screen.locked': 'Locked',
  'wallet_detail.screen.tabs.deposit_history': 'Deposit History',
  'wallet_detail.screen.tabs.withdraw_history': 'Withdraw History',
  'wallet_detail.screen.button.deposit': 'Deposit',
  'wallet_detail.screen.button.withdraw': 'Withdraw',

  //App Crypto Deposit Screen
  'crypto_deposit.screen.title': 'Deposit',
  'crypto_deposit.screen.address': 'Address',
  'crypto_deposit.screen.disabled':
      'The deposit was disabled by the administration',
  'crypto_deposit.screen.button.generate_address': 'Generate Address',
  'crypto_deposit.screen.button.copy_address': 'Copy Address',
  'crypto_deposit.screen.button.share': 'Share',
  'crypto_deposit.screen.tag.instruction':
      'Please enter both Tag and Address data, which are required to deposit @currency to your B4U account successfully.',
  'crypto_deposit.screen.button.copy_tag': 'Copy Tag',
  'crypto_deposit.screen.instruction.title':
      'Send only @currency to this deposit address',
  'crypto_deposit.screen.instruction.text1':
      'Sending coin or token other than @currency to this address may result in the loss of your deposit.',
  'crypto_deposit.screen.instruction.text2':
      'Until @confirmations confirmations are made, an equivalent amount of your assets will be temporarily unavailable for withdrawals',

  //App wallet Deposit History Screen
  'wallet_deposit_history.screen.amount': 'Amount',
  'wallet_deposit_history.screen.status': 'Status',
  'wallet_deposit_history.screen.transaction_fee': 'Transaction Fee',
  'wallet_deposit_history.screen.txid': 'TxID',
  'wallet_deposit_history.screen.date': 'Date',
  'wallet_deposit_history.screen.button.copy_txid': 'Copy TxID',
  'wallet_deposit_history.screen.button.check_explorer': 'Check Explorer',

  //App wallet Withdraw History Screen
  'wallet_withdraw_history.screen.amount': 'Amount',
  'wallet_withdraw_history.screen.status': 'Status',
  'wallet_withdraw_history.screen.address': 'Address',
  'wallet_withdraw_history.screen.transaction_fee': 'Transaction Fee',
  'wallet_withdraw_history.screen.txid': 'TxID',
  'wallet_withdraw_history.screen.date': 'Date',
  'wallet_withdraw_history.screen.button.copy_txid': 'Copy TxID',
  'wallet_withdraw_history.screen.button.check_explorer': 'Check Explorer',

  //App Crypto Withdraw Screen
  'crypto_withdraw.screen.title': 'Withdraw',
  'crypto_withdraw.screen.withdraw_disabled':
      'Withdraw is disabled by the administration',
  'crypto_withdraw.screen.enable_2fa': 'To withdraw, you have to enable 2FA',
  'crypto_withdraw.screen.button.enable_2fa': 'Enable 2FA',
  'crypto_withdraw.screen.confirm_account':
      'To withdraw you have to confirm your account',
  'crypto_withdraw.screen.button.confirm_account': 'Confirm Account',
  'crypto_withdraw.screen.field.address': 'Withdraw Address',
  'crypto_withdraw.screen.field.address.error': 'Withdrawl Address is required',
  'crypto_withdraw.screen.field.tag': 'Withdraw Tag',
  'crypto_withdraw.screen.field.tag.error':
      'Please enter a valid withdrawl tag',
  'crypto_withdraw.screen.field.amount': 'Withdraw Amount',
  'crypto_withdraw.screen.field.amount.error': 'Please enter a valid amount',
  'crypto_withdraw.screen.field.2fa': '2FA Code',
  'crypto_withdraw.screen.field.2fa.error': 'Please enter a valid 2FA code',
  'crypto_withdraw.screen.fee': 'Fee',
  'crypto_withdraw.screen.total_amount': 'Total Withdraw Amount',
  'crypto_withdraw.screen.instruction1':
      'Do not withdraw directly to a crowdfund or ICO address, as your account will not be credited with tokens from such sales.',
  'crypto_withdraw.screen.instruction2':
      'When withdrawing to the B4U user\'s address, the handling fee will be returned to the Current Account by default.',
  'crypto_withdraw.screen.button.withdraw': 'Withdraw',

  //App Fiat Deposit Screen
  'fiat_deposit.screen.title': 'Deposit',
  'fiat_deposit.screen.sub_title': 'Deposit using bank transfer',
  'fiat_deposit.screen.desc':
      'Please use the following credentials to initiate your bank transfer. Your deposit will be reflected in your account in a minimum of 2 hours.',
  'fiat_deposit.screen.disabled':
      'The deposit was disabled by the administration',
  'fiat_deposit.screen.reference_code.instruction':
      'Please use the below reference code in your payment reference.',
  'fiat_deposit.screen.reference_code': 'Reference Code',
  'fiat_deposit.screen.bank': 'Bank',

  //App fiat Withdraw Screen
  'fiat_withdraw.screen.title': 'Withdraw',
  'fiat_withdraw.screen.withdraw_disabled':
      'Withdraw is disabled by the administration',
  'fiat_withdraw.screen.enable_2fa': 'To withdraw, you have to enable 2FA',
  'fiat_withdraw.screen.button.enable_2fa': 'Enable 2FA',
  'fiat_withdraw.screen.confirm_account':
      'To withdraw you have to confirm your account',
  'fiat_withdraw.screen.button.confirm_account': 'Confirm Account',
  'fiat_withdraw.screen.button.add_beneficiary': 'Add Beneficiary',
  'fiat_withdraw.screen.field.beneficiary': 'Select Beneficiary',
  'fiat_withdraw.screen.field.beneficiary.error': 'Beneficiary is required',
  'fiat_withdraw.screen.field.amount': 'Withdraw Amount',
  'fiat_withdraw.screen.field.amount.error': 'Please enter a valid amount',
  'fiat_withdraw.screen.field.2fa': '2FA Code',
  'fiat_withdraw.screen.field.2fa.error': 'Please enter a valid 2FA code',
  'fiat_withdraw.screen.fee': 'Fee',
  'fiat_withdraw.screen.total_amount': 'Total Withdraw Amount',
  'fiat_withdraw.screen.button.withdraw': 'Withdraw',

  //App beneficiary screen
  'beneficiary.screen.title': 'Add Beneficiary',
  'beneficiary.screen.field.full_name': 'Full Name',
  'beneficiary.screen.field.account_number': 'Account Number',
  'beneficiary.screen.field.bank_name': 'Bank Name',
  'beneficiary.screen.field.bank_swift_code': 'Bank Swift Code (optional)',
  'beneficiary.screen.field.bank_inter_name':
      'Intermediary Bank Name (optional)',
  'beneficiary.screen.field.bank_inter_swift_code':
      'Intermediary Bank Swift Code (optional)',
  'beneficiary.screen.field.bank_inter_desc': 'Description',
  'beneficiary.screen.required_error': 'This field is required',
  'beneficiary.screen.button.submit': 'Submit',

  // success messages
  'success.documents.accepted': 'Documents upload was successful',
  'success.identity.accepted': 'Identity upload was successful',
  'success.withdraw.action': 'Withdrawal request was received',
  'success.otp.enabled': '2FA was enabled',
  'success.otp.disabled': '2FA was disabled',
  'success.password.changed': 'Password was changed',
  'success.password.forgot': 'Password reset link has been sent to your email',
  'success.password.changed.successfuly': 'Password was changed',
  'success.order.cancelling': 'Order is being cancelled',
  'success.order.canceled': 'Order was cancelled',
  'success.order.canceled.all': 'All orders were cancelled',
  'success.order.cancelling.all': 'All orders are being canceled',
  'success.phone.verification.send': 'Verification code was sent to your phone',
  'success.phone.confirmed': 'Your phone was confirmed',
  'success.phone.confirmation.message': 'Success!',
  'success.message.sent': 'Message was sent',
  'success.email.confirmed':
      'Your email address has been successfully confirmed',
  'success.order.created': 'Order was created',
  'success.order.done': 'Order successfully completed',
  'success.data.changed.language': 'Language has been changed',

  // error messages
  'error.order.rejected': 'Order rejected',
  'error.invalid_request': 'Order - invalid request',
  'error.bad_request': 'Order - bad request',
  'error.request_entity_too_large': 'Order - request entity too large',

  // barong
  'resource.labels.private': 'Can\'t update label',
  'resource.user.no_activity': 'No activity recorded or wrong topic',
  'resource.profile.not_exist': 'User has no profile',
  'resource.profile.exist': 'Profile already exists',
  'resource.api_key.2fa_disabled': 'Only accounts with enabled 2FA alowed',
  'resource.api_key.missing_otp':
      'Theaccount has enabled 2FA but OTP code is missing',
  'resource.api_key.invalid_otp': 'OTP code is invalid',
  'resource.phone.twillio': 'Something wrong with Twilio Client',
  'resource.phone.invalid_num': 'Phone number is invalid',
  'resource.phone.exists':
      'Phone number was not verified. Verification code was resent.',
  'resource.phone.number_exist': 'Phone number already exists',
  'resource.phone.verification_invalid':
      'Phone is not found or verification code is invalid',
  'resource.documents.limit_reached':
      'Maximum number of documents already reached',
  'resource.documents.limit_will_be_reached':
      'Documents amount will reach limit by this upload',
  'resource.otp.already_enabled':
      '2FA has been already enabled for this account',
  'resource.otp.invalid': 'OTP code is invalid',
  'resource.password.doesnt_match': 'New passwords don\'t match',
  'resource.password.prev_pass_not_correct': 'Previous password is not correct',
  'resource.password.no_change_provided':
      'New password cant be the same, as old one',
  'resource.document.empty_doc_expire': 'Expiration Date is invalid',
  'password.requirements': 'Password does not meet the minimum requirements',
  'password.password.password_strength': 'Password is too weak',

  'email.taken': 'Email already have been taken',

  'identity.user.invalid_referral_format': 'Invalid referral uid format',
  'identity.user.referral_doesnt_exist': 'Referral doesn\'t exist',
  'identity.user.active_or_doesnt_exist':
      'User doesn\'t exist or has already been activated',
  'identity.password.user_doesnt_exist': 'User doesn\'t exist',
  'identity.user.passwords_doesnt_match': 'Passwords don\'t match',
  'identity.user.utilized_token': 'JWT has already been used',
  'identity.session.invalid_login_params': 'Invalid Email or Password',
  'identity.session.invalid': 'Invalid Session',
  'identity.captcha.required': 'captcha_response is required',
  'identity.captcha.mandatory_fields': 'Mandatory fields must be filled in',
  'identity.session.not_active': 'Your account is not active',
  'identity.session.banned': 'Your account is banned',
  'identity.session.invalid_params': 'Invalid Email or Password',
  'identity.session.missing_otp':
      'The account has enabled 2FA but OTP code is missing',
  'identity.session.invalid_otp': 'OTP code is invalid',

  'first_name.invalid': 'First name is invalid',
  'last_name.invalid': 'Last name is invalid',
  'city.invalid': 'City is invalid',
  'postcode.invalid': 'Postcode is invalid',
  'address.invalid': 'Address is invalid',
  'first_name.blank': 'First name is missing or empty',
  'last_name.blank': 'Last name is missing or empty',
  'dob.blank': 'Date of birth is invalid',
  'address.blank': 'Address is missing or empty',
  'city.blank': 'City is missing or empty',
  'country.blank': 'Country is missing or empty',
  'postcode.blank': 'Postcode.blank is missing or empty',
  'country.must have alpha2 or alpha3 format':
      'Country must have alpha2 or alpha3 format',

  'totp.error': 'OTP code is invalid',

  'record.not_found': 'Record is not found',
  'jwt.decode_and_verify': 'Failed to decode and verify JWT',
  'authz.invalid_session': 'Failed to decode cookies',
  'authz.user_not_active': 'User is not active',
  'authz.invalid_signature': 'API Key header \'signature\' is invalid',
  'authz.apikey_not_active': 'API Key state is \'inactive',
  'authz.disabled_2fa': 'API Key owner has disabled 2FA',
  'authz.invalid_api_key_headers': 'Blank or missing API Key headers',
  'authz.permission_denied': 'Path is blacklisted',
  'authz.unexistent_apikey': 'X-Auth-Apikey header is invalid',
  'authz.client_session_mismatch': 'Session mismatch',
  'authz.csrf_token_mismatch': 'CSRF token mismatch',

  // validation errors
  // identity module
  'identity.user.missing_email': 'Email is missing',
  'identity.user.empty_email': 'Email is missing or empty',
  'identity.user.missing_password': 'Password is missing',
  'identity.user.empty_password': 'Password is missing or empty',
  'identity.user.missing_token': 'Token is missing',
  'identity.user.empty_token': 'Token is missing or empty',
  'identity.user.missing_reset_password_token':
      'Reset password token is missing',
  'identity.user.empty_reset_password_token':
      'Reset password token is missing or empty',
  'identity.user.missing_confirm_password': 'Confirm password is missing',
  'identity.user.empty_confirm_password':
      'Confirm password is missing or empty',

  'identity.session.missing_emai': 'Email is missing',
  'identity.session.missing_password': 'Password is missing',
  'identity.session.invalid_captcha_format': 'Invalid captcha format',

  // resource module
  'resource.otp.missing_code': 'OTP code is missing',
  'resource.otp.empty_code': 'OTP code is missing or empty',

  'resource.labels.missing_key': 'Key is missing',
  'resource.labels.empty_key': 'Key is missing or empty',
  'resource.labels.missing_value': 'Value is missing',
  'resource.labels.empty_value': 'Value is missing or empty',

  'resource.documents.missing_doc_expire':
      'Documents expiration date is missing',
  'resource.documents.empty_doc_expire':
      'Documents expiration date is missing or empty',
  'resource.documents.missing_doc_type': 'Documents type is missing',
  'resource.documents.empty_doc_type': 'Documents type is missing or empty',
  'resource.documents.missing_doc_number': 'Documents number is missing',
  'resource.documents.empty_doc_number': 'Documents number is missing or empty',
  'resource.documents.missing_upload': 'Attachment is missing',

  'resource.user.missing_topic': 'Topic is missing',
  'resource.user.empty_topic': 'Topic is missing or empty',
  'resource.user.missing_old_password': 'Old password is missing',
  'resource.user.empty_old_password': 'Old password is missing or empty',
  'resource.user.missing_new_password': 'New password is missing',
  'resource.user.empty_new_password': 'New password is missing or empty',
  'resource.user.missing_confirm_password': 'Confirm password is missing',
  'resource.user.empty_confirm_password':
      'Confirm password is missing or empty',

  'resource.profile.missing_first_name': 'First name is missing',
  'resource.profile.missing_last_name': 'Last name is missing',
  'resource.profile.missing_dob': 'Date of birth is missing',
  'resource.profile.missing_address': 'Address is missing',
  'resource.profile.missing_postcode': 'Postcode is missing',
  'resource.profile.missing_city': 'City is missing',
  'resource.profile.missing_country': 'Country is missing',

  'resource.api_key.missing_algorithm': 'Algorithm is missing',
  'resource.api_key.empty_algorithm': 'Algorithm is missing or empty',
  'resource.api_key.empty_kid': 'KID is missing or empty',
  'resource.api_key.empty_scope': 'Scope is missing or empty',
  'resource.api_key.missing_totp': 'TOTP code is missing',
  'resource.api_key.empty_totp': 'TOTP code is missing or empty',
  'resource.api_key.missing_kid': 'KID is missing',
  'resource.api_key.empty_state': 'State is missing or empty',

  'resource.phone.missing_phone_number': 'Phone number is missing',
  'resource.phone.empty_phone_number': 'Phone number is missing or empty',
  'resource.phone.missing_verification_code': 'Verification code is missing',
  'resource.phone.empty_verification_code':
      'Verification code is missing or empty',

  // peatio
  'account.currency.doesnt_exist': 'Currency doesn\'t exist',
  'account.deposit.invalid_state': 'Deposit invalid state',
  'account.deposit.non_integer_limit':
      'Value you send could not be parsed into Integer type',
  'account.deposit.invalid_limit': 'Invalid limit',
  'account.deposit.non_positive_page': 'Page value must be positive',
  'account.deposit.empty_txid': 'Txid is missing, txid is empty',
  'account.deposit_address.invalid_address_format':
      'Invalid deposit address format',
  'account.deposit_address.doesnt_support_cash_address_format':
      'Currency doesn\'t support cash address format',
  'account.withdraw.non_integer_limit':
      'Limit Value you send could not be parsed into Integer type',
  'account.withdraw.invalid_limit': 'Invalid limit',
  'account.withdraw.non_positive_page': 'Page value must be positive',
  'account.withdraw.non_integer_otp':
      'Otp value could not be parsed into Integer type',
  'account.withdraw.empty_otp': 'Otp is missing, otp is empty',
  'account.withdraw.empty_rid': 'Rid is missing, rid is empty',
  'account.withdraw.non_decimal_amount':
      'Amount value you send could not be parsed into Decimal type',
  'account.withdraw.non_positive_amount': 'Amount value must be positive',
  'account.deposit.not_permitted':
      'Deposits are allowed after phone verification',
  'account.withdraw.not_permitted':
      'Please, pass the corresponding verification steps to withdraw funds',
  'account.withdraw.insufficient_balance': 'Account balance is insufficient',
  'account.withdraw.invalid_amount': 'Invalid withdraw amount',
  'account.withdraw.create_error': 'Failed to create withdraw',
  'account.withdraw.invalid_otp': 'Invalid otp',
  'account.withdraw.disabled_api': 'Withdrawal API is disabled',
  'account.exchanges.exchange.success': 'Exchange request has been received.',
  'account.exchange.non_positive_amount':
      'Exchange field should have a positive value.',

  'market.market.doesnt_exist': 'Market doesn\'t exist',
  'market.order.invalid_state': 'Invalid deposit state',
  'market.order.invalid_limit': 'Invalid limit',
  'market.order.non_integer_limit':
      'Limit value you send could not be parsed into Integer type',
  'market.trade.empty_page': 'Page is missing or empty',
  'market.order.invalid_order_by': 'Invalid order_by',
  'market.order.invalid_side': 'Invalid order side',
  'market.order.non_decimal_volume':
      'Volume value you send could not be parsed into Decimal type',
  'market.order.non_positive_volume': 'Volume value must be positive',
  'market.order.invalid_type': 'Invalid order type',
  'market.order.non_decimal_price':
      'Volume value you send could not be parsed into Decimal type',
  'market.order.non_positive_price': 'Volume value must be positive',
  'market.order.non_integer_id':
      'Id value  you send could not be parsed into Integer type',
  'market.order.empty_id': 'Id is missing or empty',
  'market.trade.non_integer_limit':
      'Limit value you send could not be parsed into Integer type',
  'market.trade.invalid_limit': 'Invalid limit',
  'market.trade.non_integer_timestamp':
      'Timestamp value you send could not be parsed into Integer type',
  'market.trade.empty_timestamp': 'Timestamp is missing or empty',
  'market.trade.invalid_order_by': 'Invalid order_by',
  'market.order.insufficient_market_liquidity':
      'Insufficient market liquidity ',
  'market.order.invalid_volume_or_price': 'Invalid volume or price',
  'market.order.create_error': 'Failed to create error',
  'market.order.cancel_error': 'Failed to cancel error',
  'market.order.market_order_price': 'Market order doesn\'t have price',
  'market.trade.not_permitted':
      'Please, pass the corresponding verification steps to enable trading',
  'market.account.insufficient_balance': 'Account balance is insufficient',

  'public.currency.doesnt_exist': 'Currency doesn\'t exist',
  'public.currency.invalid_type': 'Invalid currency type',
  'public.market.doesnt_exist': 'Market doesn\'t exist',
  'public.order_book.non_integer_ask_limit':
      'Ask limit value you send could not be parsed into Integer type',
  'public.order_book.invalid_ask_limit': 'Invlalid ask limit',
  'public.order_book.non_integer_bid_limit':
      'Bid limir value you send could not be parsed into Integer type',
  'public.order_book.invalid_bid_limit': 'Invalid bid limit',
  'public.trade.non_integer_limit':
      'Limit value you send could not be parsed into Integer type',
  'public.trade.invalid_limit': 'Invalid limit',
  'public.trade.non_positive_page': 'Page value must be positive',
  'public.trade.non_integer_timestamp':
      'Timestamp value you send could not be parsed into Integer type',
  'public.trade.invalid_order_by': 'Invalid order by',
  'public.market_depth.non_integer_limit':
      'Limit value you send could not be parsed into Integer type',
  'public.market_depth.invalid_limit': 'Invalid limit',
  'public.k_line.non_integer_period':
      'Limit value you send could not be parsed into Integer type',
  'public.k_line.invalid_period': 'Invalid period',
  'public.k_line.non_integer_time_from':
      'Limit value you send could not be parsed into Integer type',
  'public.k_line.empty_time_from': 'Time_from param is missing or empty',
  'public.k_line.non_integer_time_to':
      'Limit value you send could not be parsed into Integer type',
  'public.k_line.empty_time_to': 'Time_to param is missing or empty',
  'public.k_line.non_integer_limit':
      'Limit value you send could not be parsed into Integer type',
  'public.k_line.invalid_limit': 'Invalid limit',

  'server.internal_error': 'Internal Server Error',
  'Server error': 'Internal Server Error',

  'password.strength.tip.influence': 'What influence on password strength',
  'password.strength.tip.number.characters': 'At least 8 characters',
  'password.strength.tip.letter':
      'At least One upper case and lower case letter',
  'password.strength.tip.digit': 'At least One digit'
};
