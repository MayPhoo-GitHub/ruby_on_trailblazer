class UserService
  class << self
    # function :getAllUsers
    # select all users
    # @return [<Type>] <users>
    def getAllUsers
      @users = UserRepository.getAllUsers
    end

    # function :createUser
    # create user
    # @param [<Type>] user <description>
    # @return [<Type>] <description>
    def createUser(user)
      @is_user_create = UserRepository.createUser(user)
    end

    # function getUserByID
    # select user by user id
    # @param [<Type>] id <description>
    # @return [<Type>] <user>
    def getUserByID(id)
      @user = UserRepository.getUserByID(id)
    end

    # function :updateUser
    # update user
    # @param [<Type>] user <description>
    # @param [<Type>] user_params <description>
    # @return [<Type>] <description>
    def updateUser(user, user_params)
      @is_user_update = UserRepository.updateUser(user, user_params)
    end

    # function :destroyUser
    # delete user
    # @param [<Type>] user <description>
    # @return [<Type>] <description>
    def destroyUser(user)
      UserRepository.destroyUser(user)
    end

    # function :findByEmail
    # find user by email
    # @param [<Type>] email <description>
    # @return [<Type>] <user>
    def findByEmail(email)
      @user = UserRepository.findByEmail(email)
    end

    # function :updateProfile
    # update profile
    # @param [<Type>] user <description>
    # @param [<Type>] user_params <description>
    # @return [<Type>] <description>
    def updateProfile(user, user_params)
      @is_update_profile = UserRepository.updateProfile(user, user_params)
    end

    # function :updatePassword
    # update user password
    # @param [<Type>] user <description>
    # @param [<Type>] password <description>
    # @return [<Type>] <description>
    def updatePassword(user, password)
      @is_update_password = UserRepository.updatePassword(user, password)
    end
  end
end
