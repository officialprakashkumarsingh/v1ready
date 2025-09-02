import 'message_model.dart';

class VisionAnalysisMessage extends Message {
  final bool isAnalyzing;
  final String? analysisPrompt;
  final String? analysisResult;

  VisionAnalysisMessage({
    required String id,
    this.isAnalyzing = true,
    this.analysisPrompt,
    this.analysisResult,
    bool isStreaming = true,
    bool hasError = false,
  }) : super(
          id: id,
          content: analysisResult ?? '',
          type: MessageType.assistant,
          timestamp: DateTime.now(),
          isStreaming: isStreaming,
          hasError: hasError,
        );

  @override
  Message copyWith({
    String? id,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    bool? isStreaming,
    bool? hasError,
    bool? isAnalyzing,
  }) {
    return VisionAnalysisMessage(
      id: id ?? this.id,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      analysisPrompt: analysisPrompt,
      analysisResult: content ?? this.analysisResult,
      hasError: hasError ?? this.hasError,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }
}