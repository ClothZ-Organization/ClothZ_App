enum LoadingStatus {
  loading,
  ready,
  error;

  bool isLoading() => this == LoadingStatus.loading;
  bool isReady() => this == LoadingStatus.ready;
  bool isError() => this == LoadingStatus.error;
}
