<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Events\NewMessage;
use App\Models\Message;
use App\Models\User;
use OpenAI\Laravel\Facades\OpenAI;

class MessageController extends Controller
{
    public function getUserMessages()
    {
        $user = auth()->user();
        $messages = $user->messages->sortByDesc('created_at');
        return response()->json($messages);
    }

    public function sendMessage(Request $request)
    {
        $validatedData = $request->validate([
            'text' => 'required|string',
        ]);
        $user = User::find(auth()->user()->id);
        $message = new Message();
        $message->text = $validatedData['text'];
        $message->sender = 'user';
        $message->user_id = $user->id;
        $message->save();

        $result = OpenAI::completions()->create([
            'model' => 'gpt-3.5-turbo-instruct',
            'prompt' => $message->text,
            'max_tokens' => 3700,
        ]);

        $response = $result['choices'][0]['text'];

        $aiMessage = new Message();
        $aiMessage->text = $response;
        $aiMessage->user_id = $user->id;
        $aiMessage->sender = 'bot';
        $aiMessage->save();

        return response($response, 200);
    }
}
