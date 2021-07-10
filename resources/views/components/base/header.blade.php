<div id="kt_header" class="header  header-fixed ">
    <div class="container-fluid d-flex align-items-center justify-content-between">
        <div class="header-menu-wrapper header-menu-wrapper-left" id="kt_header_menu_wrapper">

        </div>


        <div class="topbar">

            @if (permission('production-material-deliver'))
            <div class="dropdown">

                <div class="topbar-item" data-toggle="dropdown" data-offset="10px,0px">
                    <div class="btn btn-icon btn-clean btn-dropdown btn-lg mr-1">
                        <span class="svg-icon svg-icon-xl svg-icon-primary">
                            <i class="fas fa-bell text-primary"></i>
                            @if ((count($production_material_notification['production_materials_not_delivered']) > 0))
                            <span class="badge badge-danger text-white" style="position: absolute;top:0;right:0;">{{ count($production_material_notification['production_materials_not_delivered']) }}</span>
                            @endif
                        </span>
                    </div>
                </div>


                <div
                    class="dropdown-menu p-0 m-0 dropdown-menu-right dropdown-menu-xl dropdown-menu-anim-up">
                    <form>
                        <div class="d-flex align-items-center py-10 px-8 bgi-size-cover bgi-no-repeat rounded-top bg-primary">
                            <span class="btn btn-md btn-icon bg-white-o-15 mr-4">
                                <i class="flaticon2-shopping-cart-1 text-success"></i>
                            </span>
                            <h4 class="text-white m-0 flex-grow-1 mr-3">Production</h4>
                            <button type="button" class="btn btn-success btn-sm mr-2">
                                {{ count($production_material_notification['production_materials_not_delivered']) }}
                            </button>
                        </div>


                        <div class="scroll scroll-push" data-scroll="true" data-height="250" data-mobile-height="200">
                            @if (!empty($production_material_notification['production_materials_not_delivered']))
                                @foreach ($production_material_notification['production_materials_not_delivered'] as $item)
                                    <div class="d-flex align-items-center justify-content-between p-8">
                                        <a href="{{ url('production/view',$item->id) }}">
                                            <div class="d-flex flex-column mr-2">
                                                <span  class="font-weight-bolder text-dark-75 font-size-lg">
                                                    Batch: {{ $item->batch_no }}
                                                </span>
                                                <span>
                                                    <b>Delivery Status: </b>{!! PRODUCTION_MATERIAL_DELIVERY_LABEL[$item->material_delivered_status] !!}
                                                </span>
                                                <span><b>Start Date: </b>{{ date(config('settings.date_format'),strtotime($item->start_date))}}</span>
                                                <span><b>End Date: </b>{{ date(config('settings.date_format'),strtotime($item->end_date))}}</span>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="separator separator-solid"></div>
                                @endforeach
                            @endif
                        </div>

                        @if (permission('production-access'))
                        <div class="p-8">
                            <div class="text-center">
                                <a href="{{ route('production') }}" type="button" class="btn btn-primary text-weight-bold">View All</a>
                            </div>
                        </div>
                        @endif
                        
                    </form>
                </div>
            </div>
            @endif 

            @if (permission('production-material-receive'))
            <div class="dropdown">

                <div class="topbar-item" data-toggle="dropdown" data-offset="10px,0px">
                    <div class="btn btn-icon btn-clean btn-dropdown btn-lg mr-1">
                        <span class="svg-icon svg-icon-xl svg-icon-primary">
                            <i class="fas fa-bell text-primary"></i>
                            @if ((count($production_material_notification['production_materials_not_received']) > 0))
                            <span class="badge badge-danger text-white" style="position: absolute;top:0;right:0;">{{ count($production_material_notification['production_materials_not_received']) }}</span>
                            @endif
                        </span>
                    </div>
                </div>


                <div
                    class="dropdown-menu p-0 m-0 dropdown-menu-right dropdown-menu-xl dropdown-menu-anim-up">
                    <form>
                        <div class="d-flex align-items-center py-10 px-8 bgi-size-cover bgi-no-repeat rounded-top bg-primary">
                            <span class="btn btn-md btn-icon bg-white-o-15 mr-4">
                                <i class="flaticon2-shopping-cart-1 text-success"></i>
                            </span>
                            <h4 class="text-white m-0 flex-grow-1 mr-3">Production</h4>
                            <button type="button" class="btn btn-success btn-sm">
                                {{ count($production_material_notification['production_materials_not_received']) }}
                            </button>
                        </div>


                        <div class="scroll scroll-push" data-scroll="true" data-height="250" data-mobile-height="200">
                            @if (!empty($production_material_notification['production_materials_not_received']))
                                @foreach ($production_material_notification['production_materials_not_received'] as $item)
                                    <div class="d-flex align-items-center justify-content-between p-8">
                                        <a href="{{ url('production/view',$item->id) }}">
                                            <div class="d-flex flex-column mr-2">
                                                <span  class="font-weight-bolder text-dark-75 font-size-lg">
                                                    Batch: {{ $item->batch_no }}
                                                </span>
                                                <span>
                                                    <b>Receive Status: </b>{!! PRODUCTION_MATERIAL_DELIVERY_LABEL[$item->material_received_status] !!}
                                                </span>
                                                <span><b>Start Date: </b>{{ date(config('settings.date_format'),strtotime($item->start_date))}}</span>
                                                <span><b>End Date: </b>{{ date(config('settings.date_format'),strtotime($item->end_date))}}</span>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="separator separator-solid"></div>
                                @endforeach
                            @endif
                        </div>

                        @if (permission('production-access'))
                        <div class="p-8">
                            <div class="text-center">
                                <a href="{{ route('production') }}" type="button" class="btn btn-primary text-weight-bold">View All</a>
                            </div>
                        </div>
                        @endif
                        
                    </form>
                </div>
            </div>
            @endif




            {{-- <div class="dropdown">
                <div class="topbar-item" data-toggle="dropdown" data-offset="10px,0px">
                    <div class="btn btn-icon btn-clean btn-dropdown btn-lg mr-1">
                        <img class="h-20px w-20px rounded-sm"
                            src="http://skeleton.test/media/svg/flags/226-united-states.svg" alt="" />
                    </div>
                </div>

                <div
                    class="dropdown-menu p-0 m-0 dropdown-menu-anim-up dropdown-menu-sm dropdown-menu-right">
                    <ul class="navi navi-hover py-4">

                        <li class="navi-item">
                            <a href="#" class="navi-link">
                                <span class="symbol symbol-20 mr-3">
                                    <img src="http://skeleton.test/media/svg/flags/226-united-states.svg"
                                        alt="" />
                                </span>
                                <span class="navi-text">English</span>
                            </a>
                        </li>


                        <li class="navi-item active">
                            <a href="#" class="navi-link">
                                <span class="symbol symbol-20 mr-3">
                                    <img src="http://skeleton.test/media/svg/flags/128-spain.svg"
                                        alt="" />
                                </span>
                                <span class="navi-text">Spanish</span>
                            </a>
                        </li>


                        <li class="navi-item">
                            <a href="#" class="navi-link">
                                <span class="symbol symbol-20 mr-3">
                                    <img src="http://skeleton.test/media/svg/flags/162-germany.svg"
                                        alt="" />
                                </span>
                                <span class="navi-text">German</span>
                            </a>
                        </li>


                        <li class="navi-item">
                            <a href="#" class="navi-link">
                                <span class="symbol symbol-20 mr-3">
                                    <img src="http://skeleton.test/media/svg/flags/063-japan.svg"
                                        alt="" />
                                </span>
                                <span class="navi-text">Japanese</span>
                            </a>
                        </li>


                        <li class="navi-item">
                            <a href="#" class="navi-link">
                                <span class="symbol symbol-20 mr-3">
                                    <img src="http://skeleton.test/media/svg/flags/195-france.svg"
                                        alt="" />
                                </span>
                                <span class="navi-text">French</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div> --}}


            <div class="topbar-item">
                <div class="btn btn-icon w-auto btn-clean d-flex align-items-center btn-lg px-2"
                    id="kt_quick_user_toggle">
                    <span
                        class="text-muted font-weight-bold font-size-base d-none d-md-inline mr-1">Hi,</span>
                    <span
                        class="text-dark-50 font-weight-bolder font-size-base d-none d-md-inline mr-3">{{ Auth::user()->username }}</span>


                    <span class="symbol symbol-35 symbol-light-success">
                        <img class="header-profile-user" src="images/profile.svg" alt="Header Avatar">
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>