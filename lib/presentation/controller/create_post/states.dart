abstract class CreatePostStates {}

class CreatePostInitialState extends CreatePostStates {}

class ChangeImageState extends CreatePostStates {}

class CreatePostLoadingState extends CreatePostStates {}

class CreatePostSuccessState extends CreatePostStates {}

class CreatePostErrorState extends CreatePostStates {}