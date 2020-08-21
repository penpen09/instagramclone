class PictureMailer < ApplicationMailer
  def contact_mail(picture)
    @picture = picture
    mail to: "ar-el.mbl.10@outlook.jp", subject: "投稿確認メール"
  end
end
