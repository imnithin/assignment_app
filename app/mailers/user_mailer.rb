class UserMailer < ActionMailer::Base
  default from: "from@no-reply.com"
  def create_plan(user,plan)
    @user = user
    @plan = plan
    mail(to: @user.email, subject: 'Plan created')
  end
end
