import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/video/domain/entities/video_entity.dart';
import 'package:rafiq/features/video/domain/repos/video_repo.dart';
import 'package:rafiq/features/video/persentation/logic/admin_video_state.dart';

class AdminVideoCubit extends Cubit<AdminVideoState> {
  final VideoRepo videoRepo;
  AdminVideoCubit(this.videoRepo) : super(AdminVideoInitial());

  Future<void> addNewVideo(VideoEntity video) async {
    emit(AddVideoLoading());
    try {
      await videoRepo.addVideo(video);
      emit(AddVideoSuccess());
    } catch (e) {
      emit(AddVideoError(e.toString()));
    }
  }

  Future<void> removeVideo(String id) async {
    try {
      await videoRepo.deleteVideo(id);
      emit(DeleteVideoSuccess());
    } catch (e) {
      emit(DeleteVideoError(e.toString()));
    }
  }

  Future<void> fetchAdminVideos() async {
    emit(AdminFetchLoading());
    try {
      final videos = await videoRepo.getVideosByStage("admin_all"); 
      emit(AdminFetchSuccess(videos));
    } catch (e) {
      emit(AdminFetchError("فشل في جلب البيانات: ${e.toString()}"));
    }
  }
}