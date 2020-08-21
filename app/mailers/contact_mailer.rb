class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: "ar-el.mbl.10@outlook.jp", subject: "お問い合わせの確認メール"
  end
end
