# 🤖 Gemini AI Integration Setup

## Overview
This app now includes Google Gemini AI as a mental health assistant. The AI provides supportive guidance and general wellness advice, clearly labeled as an AI assistant (not a real psychiatrist).

## 🔧 Setup Instructions

### 1. Get Your Gemini API Key
1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy your API key

### 2. Configure the App
1. Open `lib/services/ai_service.dart`
2. Replace `YOUR_GEMINI_API_KEY_HERE` with your actual API key:
   ```dart
   static const String _apiKey = 'your-actual-api-key-here';
   ```

### 3. Run the App
```bash
flutter pub get
flutter run
```

## 🎯 Features Available

### AI Mental Health Assistant
- **Chat Interface**: Interactive conversations with AI assistant
- **Context-Aware**: Uses recent journal entries and mood data for personalized responses
- **Safety First**: Includes clear disclaimers about AI limitations
- **Professional Guidance**: Encourages seeking real professional help when needed

### AI-Powered Insights
- **Mood Analysis**: Analyzes patterns in your journal entries
- **Coping Strategies**: Suggests personalized coping techniques
- **Wellness Advice**: Provides general mental health support

## ⚠️ Important Disclaimers

- **AI is NOT a psychiatrist**: This is an AI assistant, not a licensed medical professional
- **No medical advice**: Cannot provide diagnoses or treatment recommendations
- **Emergency situations**: For mental health emergencies, contact professional services immediately
- **Professional help**: Always encouraged for serious concerns

## 🔒 Privacy & Security

- Your data is processed securely through Google's Gemini API
- No personal data is stored permanently by the AI
- Journal entries are used only for context in current conversations
- All conversations follow Google's privacy policies

## 🚀 Usage Tips

1. **Be specific**: The more context you provide, the better the AI can help
2. **Use regularly**: Check in with the AI assistant during different emotional states
3. **Combine with journaling**: Write journal entries before asking for AI insights
4. **Professional backup**: Use AI insights as a supplement, not replacement, for professional care

## 🛠️ Troubleshooting

### Common Issues:
- **"API key not configured"**: Make sure you've added your actual API key
- **"Network error"**: Check your internet connection
- **No response**: Try restarting the app

### Getting Help:
- Ensure your API key is valid and active
- Check Google AI Studio for API usage limits
- Verify your internet connection is stable
