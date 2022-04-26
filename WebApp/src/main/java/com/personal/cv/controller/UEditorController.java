package com.personal.cv.controller;

import com.alibaba.fastjson.JSON;
import com.aliyun.oss.OSSClient;
import com.personal.cv.entity.ReturnData;
import com.personal.cv.entity.SysInfo;
import com.personal.cv.service.impl.SysInfoServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;


@Controller
@RequestMapping("/ueditor")
public class UEditorController {

    @Resource
    private SysInfoServiceImpl sysInfoService;

   /* @RequestMapping(value = "/config")
    public void config(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("application/json");
        String rootPath = request.getSession().getServletContext().getRealPath("/");
        try {
            String exec = new ActionEnter(request, rootPath).exec();
            PrintWriter writer = response.getWriter();
            writer.write(exec);
            writer.flush();
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }*/

    /**
     * oss上传
     *
     * @throws Exception
     */
    @RequestMapping(value = "/ossUpload")
    public String ossUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SysInfo sysInfo = new SysInfo();
        ReturnData returnData = new ReturnData();
        List<SysInfo> list = sysInfoService.selectAll();
        for (SysInfo item : list) {
            sysInfo.setEndpoint(item.getEndpoint());
            sysInfo.setAccessKeyId(item.getAccessKeyId());
            sysInfo.setAccessKeySecret(item.getAccessKeySecret());
            sysInfo.setImgBucketName(item.getImgBucketName());
            sysInfo.setImgDomain(item.getImgDomain());
        }
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        //取得request中的所有文件名
        Iterator<String> iter = multipartRequest.getFileNames();
        if (!iter.equals(null)) {
            // 创建OSSClient实例
            OSSClient ossClient = new OSSClient(sysInfo.getEndpoint() , sysInfo.getAccessKeyId(), sysInfo.getAccessKeySecret());
            while (iter.hasNext()) {
                MultipartFile file = multipartRequest.getFile(iter.next()); //获取UEditor上传的图片
                String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                File imageFile = new File("/" + uuid + ".jpg");
                file.transferTo(imageFile);
                //返回对象
                String[] sp_fileName = file.getOriginalFilename().toString().split("\\.");
                sp_fileName[0] = uuid;
                String fileName = "image/"+sp_fileName[0] + "." + sp_fileName[1];
                returnData.setOriginal(fileName);
                returnData.setTitle(fileName);
                returnData.setState("SUCCESS");
                returnData.setUrl("http://"+sysInfo.getImgDomain()+"/" + fileName + "");

                // 上传文件
                ossClient.putObject(sysInfo.getImgBucketName(), fileName, file.getInputStream());
            }
            // 关闭client
            ossClient.shutdown();
        }
        String result = JSON.toJSONString(returnData);//这边就是为了返回给UEditor做的格式转换
        response.getWriter().write(result);
        return null;
    }

    private void close(FileOutputStream fos, FileInputStream fis) {
        if (fis != null) {
            try {
                fis.close();
            } catch (IOException e) {
                System.out.println("FileInputStream关闭失败");
                e.printStackTrace();
            }
        }
        if (fos != null) {
            try {
                fos.close();
            } catch (IOException e) {
                System.out.println("FileOutputStream关闭失败");
                e.printStackTrace();
            }
        }
    }

   /* *//**
     * 上传图片
     *
     * @return
     * @throws IOException
     * @throws IllegalStateException
     * @RequestParam("upload")MultipartFile file,
     *//*
    @RequestMapping(value = "upload")
    public String uploadImage(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ReturnUploadImage rui = null;//这个是UEditor需要的返回值内容，UEditor要的返回值需要封装成Json格式
// 转型为MultipartHttpRequest：
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
// 获得文件：
        MultipartFile file = multipartRequest.getFile("upfile"); //UEditor传到后台的是这个upfile，其他的文件上传，应该也差不多是这个，还没去研究，断点一下就知道了
// 写入文件
        File imageFile = newFile("/" + UUid() + ".jpg");
        file.transferTo(imageFile);
    //现在获取了File接下来要上传到OSS上
        if (imageFile != null) {
            rui = new ReturnUploadImage();
            rui.setTitle(imageFile.getName());//这里需要设置文件名称如：xxx.jpg
            rui.setOriginal(imageFile.getName());//这里需要设置文件名称如：xxx.jpg
// 判断文件是否为图片文件
            String r = ImageUtils.fileDetermine(imageFile, 3 * 1024);
            if (!StringUtils.isNotEmpty(r)) {
// 上传文件(这里文件类型，要根据实际上传的类型去做，暂时是直接设置了.jpg，并且先保存到磁盘，这样对磁盘比较伤，每次上传都要先保存到磁盘，然后再删除)
                ResultInfo resultInfo = OSSObjTools.uploadObject(imageFile,"subWebPublicNotice");//这里是自己封装的OSS，上传到OSS上面
// 判断如果返回结果不为空并且MD5返回值比较结果正确，就设置文件路径保存到数据库
                if (resultInfo != null && resultInfo.geteTag().equalsIgnoreCase(MD5Tools.file2MD5(imageFile))) {
                    rui.setState("SUCCESS");//这里上传成功的话一定要设置大写的 SUCCESS，失败还没测试，猜应该是FAIL，回头再去官网找找
                    rui.setUrl(CommonTools.catchUrlPath(PubParam.BUCKET_NAME,PubParam.Mark_ShenZhen) + resultInfo.getFilePath());//这里是设置返回给UEditor的图片地址
                }
            }
// 判断临时存放的文件是否存在
            if (imageFile.exists()) {
// 删除临时存放的文件
                imageFile.delete();
            }
        }
        String result = JSON.toJSONString(rui);//这边就是为了返回给UEditor做的格式转换
        response.getWriter().write(result);
        return null;
    }*/
}