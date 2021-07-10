<?php

namespace Modules\ASM\Http\Controllers;

use Carbon\Carbon;
use App\Models\ASM;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Modules\ASM\Http\Requests\ProfileUpdateFormRequest;
use Modules\ASM\Http\Requests\PasswordUpdateFormRequest;

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
        return view('asm::profile');
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
                    $avatar  = $this->upload_file($request->file('avatar'),ASM_AVATAR_PATH);
                    if(!empty($request->old_avatar)){
                        $this->delete_file($request->old_avatar, ASM_AVATAR_PATH);
                    }  
                }
                $collection = $collection->merge(compact('avatar'));
                $result     = ASM::find(Auth::guard('asm')->user()->id)->update($collection->all());
                $output     = $this->store_message($result, Auth::guard('asm')->user()->id);
                if(empty($result))
                {
                    if($request->hasFile('avatar')){
                        $this->delete_file($avatar, ASM_AVATAR_PATH);
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
            if(Auth::guard('asm')->check())
            {
                $user = Auth::guard('asm')->user();
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

    protected function track_data($update_id=null, $collection)
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
