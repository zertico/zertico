module RegisterOrganizer
  extend Zertico::Organizer

  organize [ CreateUserInteractor, SendWelcomeEmailInteractor ]
end