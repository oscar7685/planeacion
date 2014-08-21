/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.udec.controlador;

import com.udec.ejb.EncuestaFacade;
import com.udec.ejb.PersonaFacade;
import com.udec.ejb.PreguntaFacade;
import com.udec.ejb.RespuestaFacade;
import com.udec.ejb.ResultadosFacade;
import com.udec.entidades.Encuesta;
import com.udec.entidades.Persona;
import com.udec.entidades.Pregunta;
import com.udec.entidades.Respuesta;
import com.udec.entidades.Resultados;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Diana
 */
public class Encuestas extends HttpServlet {

    @EJB
    private ResultadosFacade resultadosFacade;
    @EJB
    private PersonaFacade personaFacade;
    @EJB
    private RespuestaFacade respuestaFacade;
    @EJB
    private PreguntaFacade preguntaFacade;
    @EJB
    private EncuestaFacade encuestaFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession();
        String accion = (String) request.getParameter("accion");
        try {

            if (accion.equals("crearEncuesta")) {
                String url = "encuestas/crear.jsp";
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);

            } else if (accion.equals("crearEncuesta2")) {
                String objetivo = (String) request.getParameter("objetivo");
                String nombre = (String) request.getParameter("nombre");

                Encuesta e = new Encuesta();
                e.setNombre(nombre);
                e.setObjetivo(objetivo);
                encuestaFacade.create(e);
                sesion.setAttribute("listaE", encuestaFacade.findAll());

            }

            if (accion.equals("irEncuesta")) {
                System.out.println("TU MAMA ESTA EN BOLA");
                String idencuesta = (String) request.getParameter("idencuesta");
                Encuesta e = encuestaFacade.find(Integer.parseInt(idencuesta));
                sesion.setAttribute("encuesta", e);
                sesion.setAttribute("preguntas", encuestaFacade.preguntasOrdenadasXorden(e));
                String url = "encuestas/responder.jsp";
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);

            } else if (accion.equals("guardarEncuesta")) {
                System.out.println("asjdfj");
                Encuesta encuesta = (Encuesta) sesion.getAttribute("encuesta");
                List<Pregunta> preguntas = encuesta.getPreguntaList();
                Persona p = new Persona();
                String tipo = "";
                if (encuesta.getIdencuesta() == 1) {
                    tipo = "estudiante";
                } else if (encuesta.getIdencuesta() == 2) {
                    tipo = "docente";
                } else if (encuesta.getIdencuesta() == 2) {
                    tipo = "administrativo";
                }
                p.setTipo(tipo);

                personaFacade.create(p);
                Persona recienCreado = personaFacade.findLast("idpersona").get(0);
                for (Pregunta pregunta : preguntas) {

                    if (pregunta.getTipo().equals("2") || pregunta.getTipo().equals("3") || pregunta.getTipo().equals("4")) {
                        Resultados re = new Resultados();
                        re.setPersonaIdpersona(recienCreado);
                        re.setPreguntaIdpregunta(pregunta);
                        String respuesta1 = (String) request.getParameter("respuesta" + pregunta.getIdpregunta());
                        re.setValor(respuesta1);
                        resultadosFacade.create(re);

                    } else if (pregunta.getTipo().equals("0")) {//seleccion multiple unica respuesta
                        Resultados re = new Resultados();
                        re.setPersonaIdpersona(recienCreado);
                        re.setPreguntaIdpregunta(pregunta);
                        String respuesta1 = (String) request.getParameter("pregunta" + pregunta.getIdpregunta());
                        try {
                            int idRespuesta = Integer.parseInt(respuesta1);
                            re.setRespuestaIdrespuesta(respuestaFacade.find(idRespuesta));
                        } catch (Exception e) {
                            if (respuesta1 != null && respuesta1.equals("otro")) {
                                String respuesta2 = (String) request.getParameter("preguntaOtro" + pregunta.getIdpregunta());
                                re.setValor(respuesta2);
                            }
                            if (respuesta1 == null) {
                                continue;
                            }

                        }
                        resultadosFacade.create(re);
                    } else if (pregunta.getTipo().equals("8")) {//matriz
                        List<Pregunta> subpreguntas = pregunta.getPreguntaList();
                        for (Pregunta pregunta1 : subpreguntas) {
                            Resultados re = new Resultados();
                            re.setPersonaIdpersona(recienCreado);
                            re.setPreguntaIdpregunta(pregunta1);
                            String respuesta1 = (String) request.getParameter("pregunta" + pregunta1.getIdpregunta());
                            try {
                                int idRespuesta = Integer.parseInt(respuesta1);
                                re.setRespuestaIdrespuesta(respuestaFacade.find(idRespuesta));
                            } catch (Exception e) {
                                if (respuesta1 != null && respuesta1.equals("otro")) {
                                    String respuesta2 = (String) request.getParameter("preguntaOtro" + pregunta.getIdpregunta());
                                    re.setValor(respuesta2);
                                }
                                if (respuesta1 == null) {
                                    continue;
                                }

                            }
                            resultadosFacade.create(re);

                        }

                    } else if (pregunta.getTipo().equals("6")) {//multiple respuesta sin ordenamiento
                        List<Respuesta> respuestas = pregunta.getRespuestaList();
                        for (Respuesta respuesta : respuestas) {
                            Resultados re = new Resultados();
                            re.setPersonaIdpersona(recienCreado);
                            re.setPreguntaIdpregunta(pregunta);
                            re.setRespuestaIdrespuesta(respuesta);
                            String aux = (String) request.getParameter("respuesta" + respuesta.getIdrespuesta());
                            re.setValor(aux);
                            resultadosFacade.create(re);

                        }

                    } else if (pregunta.getTipo().equals("7")) {//Solo ordenamiento
                        List<Respuesta> respuestas = pregunta.getRespuestaList();
                        for (Respuesta respuesta : respuestas) {
                            Resultados re = new Resultados();
                            re.setPersonaIdpersona(recienCreado);
                            re.setPreguntaIdpregunta(pregunta);
                            re.setRespuestaIdrespuesta(respuesta);
                            String aux = (String) request.getParameter("ordenamiR" + respuesta.getIdrespuesta());
                            re.setOrden(Integer.parseInt(aux));
                            resultadosFacade.create(re);

                        }
                    } else if (pregunta.getTipo().equals("1")) {//Seleccion multiple con ordenamiento
                        String respuestasEscogidas[] = request.getParameterValues("pregunta" + pregunta.getIdpregunta() + "[]");
                        for (int j = 0; j < respuestasEscogidas.length; j++) {
                            Resultados re = new Resultados();
                            re.setPersonaIdpersona(recienCreado);
                            re.setPreguntaIdpregunta(pregunta);

                            try {
                                int idRespuesta = Integer.parseInt(respuestasEscogidas[j]);
                                Respuesta respuesta = respuestaFacade.find(idRespuesta);
                                re.setRespuestaIdrespuesta(respuesta);
                                String aux = (String) request.getParameter("ordenR" + respuesta.getIdrespuesta());
                                re.setOrden(Integer.parseInt(aux));
                            } catch (Exception e) {
                                if (respuestasEscogidas[j] != null && respuestasEscogidas[j].equals("otro")) {
                                    String respuesta2 = (String) request.getParameter("preguntaOtro" + pregunta.getIdpregunta());
                                    re.setValor(respuesta2);
                                    String aux = (String) request.getParameter("ordenRP" + pregunta.getIdpregunta());
                                    re.setOrden(Integer.parseInt(aux));
                                }
                                if (respuestasEscogidas[j] == null) {
                                    continue;
                                }

                            }
                            resultadosFacade.create(re);
                        }

                    }

                }
            } else {
                if (accion.equals("crearPregunta")) {
                    sesion.setAttribute("listaP", preguntaFacade.findAll());
                    sesion.setAttribute("listaE", encuestaFacade.findAll());
                    String url = "preguntas/crear.jsp";
                    RequestDispatcher rd = request.getRequestDispatcher(url);
                    rd.forward(request, response);

                } else {
                    if (accion.equals("listaP")) {
                        sesion.setAttribute("listaP", preguntaFacade.findAll());
                        String url = "preguntas/listar.jsp";
                        RequestDispatcher rd = request.getRequestDispatcher(url);
                        rd.forward(request, response);

                    } else {
                        if (accion.equals("crearPregunta2")) {
                            Pregunta pre = new Pregunta();
                            String idencuesta = (String) request.getParameter("idencuesta");
                            String pregunta = (String) request.getParameter("pregunta");
                            String otro = (String) request.getParameter("otro");
                            String textoOtro = (String) request.getParameter("textoOtro");
                            String tipo = (String) request.getParameter("tipo");
                            String resp = (String) request.getParameter("respuestas").trim();
                            String[] res = resp.split("\n");
                            String[] subpre = null;
                            if (tipo.equals("8")) {
                                String subpreguntas = (String) request.getParameter("subpreguntas").trim();
                                subpre = subpreguntas.split("\n");
                            }
                            pre.setEncuestaIdencuesta(encuestaFacade.find(Integer.parseInt(idencuesta)));
                            pre.setPregunta(pregunta);
                            if (otro != null) {
                                pre.setOtro("true");
                                pre.setLabelOtro(textoOtro);

                            }

                            pre.setTipo(tipo);
                            //0
                            //1

                            preguntaFacade.create(pre);
                            Pregunta ultima = preguntaFacade.findLast("idpregunta").get(0);

                            if (tipo.equals("0") || tipo.equals("1") || tipo.equals("6") || tipo.equals("7") || tipo.equals("8")) {
                                for (String re : res) {
                                    Respuesta r = new Respuesta();
                                    r.setRespuesta(re);
                                    r.setPreguntaIdpregunta(ultima);
                                    respuestaFacade.create(r);
                                }
                                List<Respuesta> respuestas = respuestaFacade.findByList("preguntaIdpregunta", ultima);
                                ultima.setRespuestaList(respuestas);

                            }
                            if (tipo.equals("8")) {
                                for (String subpre1 : subpre) {
                                    Pregunta sub = new Pregunta();
                                    sub.setPregunta(subpre1);
                                    sub.setPreguntaPadre(ultima);
                                    preguntaFacade.create(sub);
                                }
                                List<Pregunta> subs = preguntaFacade.findByList("preguntaPadre", ultima);
                                ultima.setPreguntaList(subs);
                            }
                            preguntaFacade.edit(ultima);
                            sesion.setAttribute("listaP", preguntaFacade.findAll());

                        } else {
                            if (accion.equals("listaE")) {
                                sesion.setAttribute("listaE", encuestaFacade.findAll());
                                String url = "encuestas/listar.jsp";
                                RequestDispatcher rd = request.getRequestDispatcher(url);
                                rd.forward(request, response);
                            } else {
                                if (accion.equals("ordenarP")) {
                                    String encu = (String) request.getParameter("encuesta");
                                    Encuesta e = encuestaFacade.find(Integer.parseInt(encu));
                                    sesion.setAttribute("encuesta", e);
                                    sesion.setAttribute("preguntas", encuestaFacade.preguntasOrdenadasXorden(e));
                                    String url = "encuestas/ordenarP.jsp";
                                    RequestDispatcher rd = request.getRequestDispatcher(url);
                                    rd.forward(request, response);
                                } else {
                                    if (accion.equals("ordenarPreguntas")) {
                                        String orden = request.getParameter("order");
                                        String separados[] = orden.split(",");
                                        for (int i = 0; i < separados.length; i++) {
                                            Pregunta aux = preguntaFacade.find(Integer.parseInt(separados[i]));
                                            aux.setOrden(i + 1);
                                            preguntaFacade.edit(aux);
                                        }
                                    } else {
                                        if (accion.equals("Condicionar")) {
                                            String encu = (String) request.getParameter("encuesta");
                                            Encuesta e = encuestaFacade.find(Integer.parseInt(encu));
                                            sesion.setAttribute("encuesta", e);
                                            sesion.setAttribute("preguntas", encuestaFacade.preguntasOrdenadasXorden(e));
                                            String url = "encuestas/condicionarP.jsp";
                                            RequestDispatcher rd = request.getRequestDispatcher(url);
                                            rd.forward(request, response);
                                        }

                                    }

                                }

                            }
                        }
                    }
                }
            }
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
