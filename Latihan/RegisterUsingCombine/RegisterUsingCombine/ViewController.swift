import UIKit
import Combine
 
class ViewController: UIViewController {
 
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var signUpButton: UIButton!
 
  var cancellables: Set<AnyCancellable> = []
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupCombine()
  }
 
  private func setupView() {
    signUpButton.isEnabled = false
    signUpButton.backgroundColor = UIColor.systemGray
 
    let textFields: [UITextField] = [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField]
    for textField in textFields {
      setupTextFields(for: textField)
    }
  }
 
  private func setupTextFields(for textField: UITextField) {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    button.frame = CGRect(
      x: CGFloat(nameTextField.frame.size.width - 25),
      y: CGFloat(5),
      width: CGFloat(25),
      height: CGFloat(25)
    )
 
    switch textField {
    case nameTextField:
      button.addTarget(self, action: #selector(self.showNameExistAlert(_:)), for: .touchUpInside)
    case emailTextField:
      button.addTarget(self, action: #selector(self.showEmailExistAlert(_:)), for: .touchUpInside)
    case passwordTextField:
      button.addTarget(self, action: #selector(self.showPasswordExistAlert(_:)), for: .touchUpInside)
    case confirmPasswordTextField:
      button.addTarget(self, action: #selector(self.showConfirmationPasswordExistAlert(_:)), for: .touchUpInside)
    default:
      print("TextField not found")
    }
 
    textField.rightView = button
  }
 
  @IBAction func showNameExistAlert(_ sender: Any) {
    let alertController = UIAlertController(
      title: "Your name is invalid.",
      message: "Please double check your name, for example Gilang Ramadhan.",
      preferredStyle: .alert
    )
 
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alertController, animated: true, completion: nil)
  }
 
  @IBAction func showEmailExistAlert(_ sender: Any) {
    let alertController = UIAlertController(
      title: "Your email is invalid.",
      message: "Please double check your email format, for example like gilang@dicoding.com.",
      preferredStyle: .alert
    )
 
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alertController, animated: true, completion: nil)
  }
 
  @IBAction func showPasswordExistAlert(_ sender: Any) {
    let alertController = UIAlertController(
      title: "Your password is invalid.",
      message: "Please double check the character length of your password.",
      preferredStyle: .alert
    )
 
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alertController, animated: true, completion: nil)
  }
 
  @IBAction func showConfirmationPasswordExistAlert(_ sender: Any) {
    let alertController = UIAlertController(
      title: "Confirmation passwords do not match.",
      message: "Please check your password confirmation again.",
      preferredStyle: .alert
    )
 
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alertController, animated: true, completion: nil)
  }
 
  private func isValidEmail(from email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
 
  private func setupCombine() {
    let namePublisher = NotificationCenter.default
      .publisher(for: UITextField.textDidChangeNotification, object: nameTextField)
      .map { ($0.object as? UITextField)?.text }
      .replaceNil(with: "")
      .map { !$0.isEmpty }
    namePublisher.sink(receiveValue: { value in
      self.nameTextField.rightViewMode = value ? .never : .always
    }).store(in: &cancellables)
 
    let emailPublisher = NotificationCenter.default
      .publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
      .map { ($0.object as? UITextField)?.text }
      .replaceNil(with: "")
      .map { self.isValidEmail(from: $0) }
    emailPublisher.sink(receiveValue: { value in
      self.emailTextField.rightViewMode = value ? .never : .always
    }).store(in: &cancellables)
 
    let passwordPublisher = NotificationCenter.default
      .publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
      .map { ($0.object as? UITextField)?.text }
      .replaceNil(with: "")
      .map { $0.count > 5 }
    passwordPublisher.sink(receiveValue: { value in
      self.passwordTextField.rightViewMode = value ? .never : .always
    }).store(in: &cancellables)
 
    let confirmationPasswordPublisher = Publishers.Merge(
      NotificationCenter.default
        .publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
        .map { ($0.object as? UITextField)?.text }
        .replaceNil(with: "")
        .map { $0.elementsEqual(self.confirmPasswordTextField.text ?? "") },
      NotificationCenter.default
        .publisher(for: UITextField.textDidChangeNotification, object: confirmPasswordTextField)
        .map { ($0.object as? UITextField)?.text }
        .replaceNil(with: "")
        .map { $0.elementsEqual(self.passwordTextField.text ?? "") }
    )
    confirmationPasswordPublisher.sink(receiveValue: { value in
      self.confirmPasswordTextField.rightViewMode = value ? .never : .always
    }).store(in: &cancellables)
 
    let invalidFieldsPublisher = Publishers.CombineLatest4(
      namePublisher,
      emailPublisher,
      passwordPublisher,
      confirmationPasswordPublisher
    ).map { name, email, password, confirmationPassword in
      name && email && password && confirmationPassword
    }
    invalidFieldsPublisher.sink(receiveValue: { isValid in
      if (isValid) {
        self.signUpButton.isEnabled = true
        self.signUpButton.backgroundColor = UIColor.systemGreen
      } else {
        self.signUpButton.isEnabled = false
        self.signUpButton.backgroundColor = UIColor.systemGray
      }
    }).store(in: &cancellables)
  }
 
}
