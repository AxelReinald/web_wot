import 'package:bloc/bloc.dart';
import 'package:web_wot/bloc/settinggroupbloc/setting_group_bloc.dart';
import 'package:web_wot/model/companymodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/service/restapi.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  RestApi api = RestApi();
  ResponseSearchComp respcom = ResponseSearchComp();
  ResponseComBusiness respbus = ResponseComBusiness();
  ResponseComType resptype = ResponseComType();
  ResponseComCity respcity = ResponseComCity();
  RequestComAdd reqadd = RequestComAdd();
  RequestComDelete reqdel = RequestComDelete();
  DownloadResponseComp respdown = DownloadResponseComp();
  UploadComresponse respup = UploadComresponse();
  ResponseDownloadTemplateCom resptemp = ResponseDownloadTemplateCom();
  CompanyBloc() : super(CompanyInitial()) {
    on<CompanyEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(CompanyLoading());
        if (event is SearchCom) {
          respcom = await searchresp(event.reqcom);
          emit(SearchComSuccess(respcom));
        } else if (event is GetBusiness) {
          respbus = await getbusiness();
          emit(GetDataBusinessSuccess(respbus));
        } else if (event is GetTypeCom) {
          resptype = await gettype();
          emit(GetDataTypeSuccess(resptype));
        } else if (event is GetCityCom) {
          respcity = await getcity();
          emit(GetDataCitySuccess(respcity));
        } else if (event is AddCom) {
          reqadd = await addrespon(event.reqadd);
          emit(AddComSuccess(reqadd));
        } else if (event is EditCom) {
          reqadd = await editrespon(event.reqedit);
          emit(EditComSuccess(reqadd));
        } else if (event is DeleteCom) {
          reqdel = await deleteresponse(event.delreq);
          emit(DeleteComSuccess(reqdel));
        } else if (event is DownloadFileCom) {
          respdown = await downloadrespon(event.downfile);
          emit(DownloadComSuccess(respdown));
        } else if (event is UploadComFile) {
          respup = await uploadrespon(event.req);
          emit(UploadComSuccess(respup));
        } else if (event is DownloadTemplateCom) {
          resptemp = await downloadtemp();
          emit(TemplateComSuccess(resptemp));
        }
      } catch (e) {
        emit(CompanyError(e.toString()));
      }
    });
  }

  searchresp(RequestSearchComp req) async {
    ResponseSearchComp rescom = ResponseSearchComp();
    rescom = await api.searchcomp(req.toJson());
    return rescom;
  }

  getbusiness() async {
    ResponseComBusiness getbus = ResponseComBusiness();
    getbus = await api.GetBusinessCmb();
    return getbus;
  }

  gettype() async {
    ResponseComType gettype = ResponseComType();
    gettype = await api.GetTypeCmb();
    return gettype;
  }

  getcity() async {
    ResponseComCity getcity = ResponseComCity();
    getcity = await api.GetCityCmb();
    return getcity;
  }

  addrespon(RequestComAdd add) async {
    RequestComAdd reqadds = RequestComAdd();
    reqadds = await api.AddCompData(add.toJson());
    return reqadds;
  }

  editrespon(RequestComAdd edit) async {
    RequestComAdd editreq = RequestComAdd();
    editreq = await api.EditCompData(edit.toJson());
    return editreq;
  }

  deleteresponse(RequestComDelete req) async {
    RequestComDelete delreq = RequestComDelete();
    delreq = await api.DeleteComData(req.toJson());
    return delreq;
  }

  downloadrespon(DownlaodRequestComp req) async {
    DownloadResponseComp downresp = DownloadResponseComp();
    downresp = await api.DownloadReqData(req.toJson());
    return downresp;
  }

  uploadrespon(File_Data_Model req) async {
    UploadComresponse upresp = UploadComresponse();
    upresp = await api.UploadReqData(req);
    return upresp;
  }

  downloadtemp() async {
    ResponseDownloadTemplateCom resp = ResponseDownloadTemplateCom();
    resp = await api.DownloadTemplateComp();
    return resp;
  }
}
