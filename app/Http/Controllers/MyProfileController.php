<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\User;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use App\Http\Requests\ProfileUpdateFormRequest;
use App\Http\Requests\PasswordUpdateFormRequest;
use Auth, Hash;

class MyProfileController extends Controller
{
    use UploadAble;
    protected function setPageData(string $page_title, string $sub_title=null, string $page_icon=null, $breadcrumb=null)
    {
        view()->share(['page_title' => $page_title, 'sub_title' => $sub_title ?? $page_title, 'page_icon' => $page_icon, 'breadcrumb' => $breadcrumb]);
    }

    public function index()
    {
        $this->setPageData('My Profile','My Profile','far fa-id-badge');
        return view('user.profile');
    }

    public function updateProfile(ProfileUpdateFormRequest $request)
    {
        if($request->ajax())
        {
            if(auth()->check())
            {
                $collection = collect($request->validated())->except(['username','avatar']);
                $collection = $this->track_data($collection,$request->update_id);
                $avatar     = !empty($request->old_avatar) ? $request->old_avatar : null;
                if($request->hasFile('avatar')){
                    $avatar  = $this->upload_file($request->file('avatar'),USER_PHOTO_PATH);
                    if(!empty($request->old_avatar)){
                        $this->delete_file($request->old_avatar, USER_PHOTO_PATH);
                    }  
                }
                $collection = $collection->merge(compact('avatar'));
                $result     = User::updateOrCreate(['id'=>auth()->user()->id],$collection->all());
                $output     = $this->store_message($result, auth()->user()->id);
                if(empty($result))
                {
                    if($request->hasFile('avatar')){
                        $this->delete_file($avatar, USER_PHOTO_PATH);
                    }
                }
                return response()->json($output);
            }
            
        }
    }

    public function updatePassword(PasswordUpdateFormRequest $request)
    {
        if($request->ajax())
        {
            if(auth()->check())
            {
                $user = Auth::user();

                if (!Hash::check($request->current_password, $user->password)) {
                    $output = ['status'=>'error','message'=>'Current password does not match!'];
                }else{
                    $user->password = $request->password;
                    if($user->save()){
                        $output = ['status'=>'success','message'=>'Password changed successfully'];
                    }else{
                        $output = ['status'=>'error','message'=>'Failed to change password. Try Again!'];
                    }
                }
                return response()->json($output);
            }
            
        }
    }

    protected function track_data($collection,$update_id=null)
    {
        $created_by   = $modified_by = auth()->user()->username;
        $created_at   = $updated_at  = Carbon::now();   
        return $update_id ? $collection->merge(compact('modified_by','updated_at')) : $collection->merge(compact('created_by','created_at'));
    }

    protected function store_message($result, $update_id = null)
    {
        return $result ? ['status' => 'success','message' => !empty($update_id) ? 'Data Has Been Updated Successfully' : 'Data Has Been Saved Successfully']
        : ['status' => 'error','message' => !empty($update_id) ? 'Failed To Update Data' : 'Failed To Save Data'];
    }
}
