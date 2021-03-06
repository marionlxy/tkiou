package com.taikang.udp.view.controller;

import org.springframework.stereotype.Controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestMapping;
import com.taikang.udp.common.util.CommUtil;
import com.taikang.udp.sys.action.IUserAction;
import com.taikang.udp.sys.model.UserBO;


@Controller
public class VerifyController {
	
	@Resource(name=IUserAction.ACTION_ID)
	private IUserAction userAction;
    
    
    @RequestMapping("/verify_username.htm")
    public void verify_username(HttpServletRequest request,
            HttpServletResponse response, String userName, Long id) {
        boolean ret = true;
        UserBO user = new UserBO();
        user.setUsername(userName);
        user.setId(id);
        List<UserBO> users = userAction.verifyAlreadyExists(user);
        if (users != null && users.size() > 0) {
            ret = false;
        }
        response.setContentType("text/plain");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer;
        try {
            writer = response.getWriter();
            writer.print(ret);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 验证Email
     * 
     * @param request
     * @param response
     * @param userName
     */
    @RequestMapping("/verify_email.htm")
    public void verify_email(HttpServletRequest request,
            HttpServletResponse response, String email, Long id) {
        boolean ret = true;
        UserBO user = new UserBO();
        user.setEmail(email);
        user.setId(id);
        List<UserBO> users = userAction.verifyAlreadyExists(user);
        if (users != null && users.size() > 0) {
            ret = false;
        }
        response.setContentType("text/plain");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer;
        try {
            writer = response.getWriter();
            writer.print(ret);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    /**
     * 验证码生成
     * 
     * @param response
     * @param mobile
     * @throws IOException
     */
    @RequestMapping("/verify.htm")
    public void verify(HttpServletRequest request,
            HttpServletResponse response, String name) throws IOException {
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HttpSession session = request.getSession(false);
        // 在内存中创建图象
        int width = 73, height = 27;
        BufferedImage image = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);

        // 获取图形上下文
        Graphics g = image.getGraphics();
        // 生成随机类
        Random random = new Random();
        // 设定背景色
        g.setColor(getRandColor(200, 250));
        g.fillRect(0, 0, width, height);
        // 设定字体
        g.setFont(new Font("Times New Roman", Font.PLAIN, 24));

        // 画边框
        // g.setColor(new Color());
        // g.drawRect(0,0,width-1,height-1);

        // 随机产生155条干扰线，使图象中的认证码不易被其它程序探测到
        g.setColor(getRandColor(160, 200));
        for (int i = 0; i < 155; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            g.drawLine(x, y, x + xl, y + yl);
        }

        // 取随机产生的认证码(4位数字)
        String sRand = "";
        for (int i = 0; i < 4; i++) {
            String rand = CommUtil.randomInt(1).toUpperCase();
            sRand += rand;
            // 将认证码显示到图象中
            g.setColor(new Color(20 + random.nextInt(110), 20 + random
                    .nextInt(110), 20 + random.nextInt(110)));// 调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
            g.drawString(rand, 13 * i + 6, 24);
        }

        // 将认证码存入SESSION
        if (CommUtil.null2String(name).equals("")) {
            session.setAttribute("verify_code", sRand);
        } else {
            session.setAttribute(name, sRand);
        }
        // 图象生效
        g.dispose();
        ServletOutputStream responseOutputStream = response.getOutputStream();
        // 输出图象到页面
        ImageIO.write(image, "JPEG", responseOutputStream);

        // 以下关闭输入流！
        responseOutputStream.flush();
        responseOutputStream.close();
    }
    
    private Color getRandColor(int fc, int bc) {// 给定范围获得随机颜色
        Random random = new Random();
        if (fc > 255)
            fc = 255;
        if (bc > 255)
            bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }
    
    /**
     * 验证码ajax验证方法
     * 
     * @param response
     */
    @RequestMapping("/verify_code.htm")
    public void validate_code(HttpServletRequest request,
            HttpServletResponse response, String code, String code_name) {
        HttpSession session = request.getSession(false);
        String verify_code = "";
        if (CommUtil.null2String(code_name).equals("")) {
            verify_code = (String) session.getAttribute("verify_code");
        } else {
            verify_code = (String) session.getAttribute(code_name);
        }
        boolean ret = true;
        if (verify_code != null && !verify_code.equals("")) {
            if (!CommUtil.null2String(code.toUpperCase()).equals(verify_code)) {
                ret = false;
            }
        }
        response.setContentType("text/plain");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        PrintWriter writer;
        try {
            writer = response.getWriter();
            writer.print(ret);
        } catch (IOException e) {
            e.printStackTrace();
           
        }
    }

}
